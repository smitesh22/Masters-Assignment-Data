library(aimsir17)
library(ggplot2)
library(dplyr)

observations %>% 
  group_by(station, day, month) %>% 
  summarise(TotalRain = sum(rain)) %>%
  