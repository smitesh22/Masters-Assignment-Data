# Smitesh Patil
# student id: 22223696

library(aimsir17)=
library(dplyr)
library(ggplot2)
library(purrr)
library(tidyr)
library(ggpubr)
library(randomcoloR)

set.seed(200)

ener <- aimsir17::eirgrid17 %>%
  group_by(year, month, day, hour) %>%
  summarise(AvrWindGen = mean(IEWindGeneration)) %>% ungroup()

glimpse(ener)
  
ds <- left_join(ener, aimsir17::observations)


# ds after left join

ds

glimpse(ds)


# no of rows with incomplete data
sum(!complete.cases(ds))

# only taking complete cases and taking 10 percent of ds
ds <- ds %>% filter(complete.cases(.)) %>%
  sample_frac(0.01)

glimpse(ds)

# confirming no incomplete cases in ds
sum(!complete.cases(ds))

# creating tibble for each station and running linear model on station for a hypotheses
ds_n <- ds %>% group_by(station) %>%
  nest() %>% 
  mutate(LM = map(data,
                  ~lm(AvrWindGen ~ wdsp, data = .)))

ds_n 

# r squared values of linear model
ds_n <- ds_n %>%
  mutate(
         summary = map(LM, ~summary(.x)),
         r_squared = map_dbl(summary, pluck, "r.squared")) %>%
  arrange(desc(r_squared)) %>%
  select(station, data, LM, r_squared)

ds_n

# plots for linear models for the stations
ds_n <- ds_n %>%
  mutate(plots = map2(data, station, ~{ggplot(.x,
    aes(x= wdsp,
        y = AvrWindGen))+
      xlab("speed")+
      ylab("power")+
      ggtitle(.y)+
      geom_smooth()+
      geom_point(colour=randomColor(luminosity="light")) +
      theme_classic()
  }))

# plotting the ggplot objects in the tibble
ggarrange(plotlist = ds_n$plots)
