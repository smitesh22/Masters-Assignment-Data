#name : Smitesh patil
#std. id : 22223696

library(aimsir17)
library(ggplot2)
library(dplyr)

s_data <- observations %>% 
  group_by(station, day, month) %>% 
  summarise(TotalRain = sum(rain), AvrTemp = mean(temp)) %>%
  ungroup()

# s_data contains station-wise rain and temp data by month
print(s_data)

#glimpse of s_data
glimpse(s_data)

s_data_diff <- s_data %>%
  arrange(month)

s_data_diff <- s_data_diff %>%
  mutate(LagTotalRain = lag(s_data_diff['TotalRain']),
         LagAvgTemp = lag(s_data_diff['AvrTemp'])) %>%
  mutate(RainDiff = TotalRain - LagTotalRain,
         MeanTempDiff = AvrTemp - LagAvgTemp) %>%
  mutate(AbsRainDiff = abs(RainDiff),
         AbsMeanTempDiff = abs(MeanTempDiff)) %>%
  mutate(RainDiff = RainDiff[, 1],
         AbsRainDiff = AbsRainDiff[, 1],
         MeanTempDiff = MeanTempDiff[, 1],
         AbsMeanTempDiff = AbsMeanTempDiff[, 1]) %>%
  select(station, day, month, TotalRain, AvrTemp,
         RainDiff, AbsRainDiff, MeanTempDiff, AbsMeanTempDiff)

#s_data_diff contains s_data with rain difference and temperature
#compared to next day and absolute values
print(s_data_diff)

out <- s_data_diff %>%group_by(station, month) %>%
  summarise(AvgDiffTemp = mean(MeanTempDiff, na.rm=T),
            SDDiffTemp = sd(MeanTempDiff, na.rm=T),
            MinDiffTemp = min(MeanTempDiff, na.rm=T), 
            MaxDiffTemp = max(MeanTempDiff, na.rm=T),
            AvgDiffRain = mean(RainDiff, na.rm=T),
            SDDiffRain = sd(RainDiff, na.rm=T),
            MinDiffRain = min(RainDiff, na.rm=T),
            MaxDiffRain = max(RainDiff, na.rm=T))

#out contains mean, max, min and standard deviations of rain and tempature values 
#grouped monthly

print(out)

# first plot for Temperature data
ggplot(out,aes(x = month))+
  geom_line(aes(y = MinDiffTemp), colour="Blue") +
  geom_line(aes(y = MaxDiffTemp), colour="Blue") +
  facet_wrap(~station) +
  geom_ribbon(aes(ymin = -SDDiffTemp, ymax = SDDiffTemp),fill="Red") +
  geom_point(aes(y = AvgDiffTemp))+
  geom_line(aes(y = AvgDiffTemp))+
  coord_cartesian(ylim = c(-5, 5))+
  scale_x_continuous(breaks = seq(1, 12, by = 1))+
  ylab("AvrDiffTemp")+
  xlab("month")

# second plot for Rain data
ggplot(out,aes(x = month))+
  geom_line(aes(y = MinDiffRain), colour="Red") +
  geom_line(aes(y = MaxDiffRain), colour="Red") +
  geom_ribbon(aes(ymin = -SDDiffRain, ymax = SDDiffRain),fill="blue") +
  geom_point(aes(y = AvgDiffRain))+
  geom_line(aes(y = AvgDiffRain))+
  facet_wrap(~station) +
  coord_cartesian(ylim = c(-25, 25)) +
  scale_x_continuous(breaks = seq(1, 12, by = 1))+
  ylab("AvgDiffRain")+
  xlab("month")