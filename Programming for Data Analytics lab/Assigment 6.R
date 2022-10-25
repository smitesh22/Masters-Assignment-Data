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


out <- s_data_diff %>%group_by(station, month) %>%
  summarise(AvgDiffTemp = mean(MeanTempDiff, na.rm=T),
            SDDiffTemp = sd(MeanTempDiff, na.rm=T),
            MinDiffTemp = min(MeanTempDiff, na.rm=T), 
            MaxDiffTemp = max(MeanTempDiff, na.rm=T),
            AvgDiffRain = mean(RainDiff, na.rm=T),
            SDDiffRain = sd(RainDiff, na.rm=T),
            MinDiffRain = min(RainDiff, na.rm=T),
            MaxDiffRain = max(RainDiff, na.rm=T))

ggplot(out,aes(x = month))+
  geom_line(aes(y = MinDiffTemp), colour="Blue") +
  geom_line(aes(y = MaxDiffTemp), colour="Blue") +
  facet_wrap(~station) +
  geom_ribbon(aes(ymin = -SDDiffTemp, ymax = SDDiffTemp),fill="Red") +
  geom_point(aes(y = AvgDiffTemp))+
  geom_line(aes(y = AvgDiffTemp))+
  coord_cartesian(ylim = c(5, -5))


ggplot(out,aes(x = month))+
  geom_line(aes(y = MinDiffRain), colour="Red") +
  geom_line(aes(y = MaxDiffRain), colour="Red") +
  geom_ribbon(aes(ymin = -SDDiffRain, ymax = SDDiffRain),fill="blue") +
  geom_point(aes(y = AvgDiffRain))+
  geom_line(aes(y = AvgDiffRain))+
  facet_wrap(~station) +
  coord_cartesian(ylim = c(20, -20))
