library(aimsir17)
library(ggplot2)
library(dplyr)

s_data <- observations %>% 
  group_by(station, day, month) %>% 
  summarise(TotalRain = sum(rain), AvrTemp = mean(temp))
  
glimpse(s_data)

arranged_data<- s_data %>%
  arrange(month)

s_data_diff <- 
  cbind(arranged_data,lag(arranged_data))

s_data_diff <- s_data_diff[,c(1, 2, 3, 4, 5, 9, 10)] %>% 
  mutate(RainDiff = TotalRain...4 - TotalRain...9,
         MeanTempDiff = AvrTemp...5 - AvrTemp...10) 

s_data_diff <- s_data_diff %>% select(station...1, day...2, month...3,
                       TotalRain...4, AvrTemp...5, RainDiff, MeanTempDiff) %>%
  mutate(AbsRainDiff = abs(RainDiff), AbsMeanTempDiff = abs(MeanTempDiff)) %>%
  select(station = station...1, day = day...2, month = month...3,
         TotalRain = TotalRain...4, AvrTemp= AvrTemp...5, RainDiff, AbsRainDiff,
         MeanTempDiff, AbsMeanTempDiff)


