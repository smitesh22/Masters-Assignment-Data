#Name: Smitesh Patil
#Student id : 22223696

library(aimsir17)
library(ggplot2)
library(dplyr)
library(tidyr)

obs <- observations %>% filter(station == "MACE HEAD" | 
                              station == "DUBLIN AIRPORT"|
                              station == "SherkinIsland") %>%
  mutate(Season = case_when(month %in% c(11,12,1) ~ "Winter",
                            month %in% c(2,3,4) ~ "Spring",
                            month %in% c(5,6,7) ~ "Summer",
                            month %in% c(8,9,10) ~ "Autumn"))
obs

glimpse(obs)

ener <- eirgrid17 %>%
  group_by(year, month, day, hour) %>%
  summarise(IE = mean(IEDemand, na.rm=T),
            NI = mean(NIDemand, na.rm=T),
            CheckObs = n()) %>%
  ungroup()


ds <- left_join(ener, obs, by = c("year", "month", "day", "hour"))
set.seed(100)
ds <- sample_frac(ds, 0.1, replace = F)

ds

glimpse(ds)

ds <- ds %>%
  select(station, month, temp, Season, IE, NI)

ds1 <- pivot_longer(ds, 5:6, names_to = "Area", values_to = "Demand")

ggplot(ds1, aes(x = temp, y=Demand, color = Area)) + 
  geom_point()+
  geom_smooth(method = lm)+
  facet_grid(cols = vars(Season), vars(rows = station))

ggplot(ds1, aes(x = temp, y=Demand, color = Area)) + 
  geom_point()+
  geom_smooth(method = lm)+
  facet_grid(cols = vars(month), vars(rows = station))

  
cor_season <- ds %>% group_by(station, Season) %>% 
  summarise(Corr_IE = cor(temp, IE), 
            Corr_NI = cor(temp, NI),
            Diff = Corr_IE - Corr_NI)

slice(cor_season,1:nrow(cor_season))

cor_month <- ds %>%group_by(station, month) %>%
  summarise(Corr_IE = cor(IE, temp), 
            Corr_NI = cor(NI, temp),
            Diff = Corr_IE - Corr_NI)
slice(cor_month,1:nrow(cor_month))
 
