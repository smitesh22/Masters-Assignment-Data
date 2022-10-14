library(nycflights13)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tibble)



d <- nycflights13::flights
d$hour <- as.factor(d$hour)

d <- d %>%
  select(month, hour, origin, day, dep_delay, arr_delay, air_time,
         distance, carrier) %>%
  mutate(monthName = month(month, label = T), .after = month)


boxplot <- subset(d, dep_delay <= 30 & dep_delay >= -30)


ggplot(boxplot, aes(x = monthName, y = dep_delay, color = factor(origin))) + 
  geom_boxplot() + 
  xlab("Month") +
  ylab("Departure Delay") +
  ggtitle("Delay Delays by Month (range -30 to 30 minutes shown)")


ggplot(boxplot, aes(x = hour, y = dep_delay, color = factor(origin))) + 
  geom_boxplot() + 
  xlab("Hhour") +
  ylab("Departure Delay") +
  ggtitle("Delay Delays by Hour (range -30 to 30 minutes shown)")


ggplot(d, aes(x = air_time, fill = factor(origin))) + 
  geom_histogram() +
  facet_wrap(~ origin, ncol = 1)

ggplot(d, aes(x = distance, fill = factor(origin))) + 
  geom_histogram() +
  facet_wrap(~ origin, ncol = 1)

ggplot(d, aes(x = carrier, fill = factor(origin))) + 
  geom_histogram(stat = "count")

set.seed(100)
d1 <- d[sample(nrow(d), 3000), ]

ggplot(d1, aes(x = dep_delay, y = arr_delay, color = factor(origin)))+geom_point()+geom_smooth()
