#Name : Smitesh Patil
# Student Id : 2223696

library(nycflights13)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tibble)



d <- nycflights13::flights
d$hour <- as.factor(d $hour)

d <- d %>%
  select(month, hour, origin, day, dep_delay, arr_delay, air_time,
         distance, carrier) %>%
  mutate(monthName = month(month, label = T), .after = month)


boxplot <- subset(d, dep_delay <= 30 & dep_delay >= -30)

# Q1. Plot Box plots for departure delay by month
ggplot(boxplot, aes(x = monthName, y = dep_delay, color = factor(origin))) + 
  geom_boxplot() + 
  xlab("Month") +
  ylab("Departure Delay") +
  labs(color = "origin") +
  ggtitle("Delay Delays by Month (range -30 to 30 minutes shown)") +
  theme(legend.position = "top")

# Q2. Plot departure delay by hour  
ggplot(boxplot, aes(x = hour, y = dep_delay, color = factor(origin))) + 
  geom_boxplot() + 
  xlab("Hhour") +
  ylab("Departure Delay") +
  labs(color = "origin") + 
  ggtitle("Delay Delays by Hour (range -30 to 30 minutes shown)") +
  theme(legend.position = "bottom")


# Q3. Histogram for airtime by airport

ggplot(d, aes(x = air_time, fill = factor(origin))) + 
  geom_histogram() +
  ylab("Number of flights") +
  xlab("Time in air") + 
  facet_wrap(~ origin, ncol = 1) +
  ggtitle("History of Airtime from each airport") + 
  theme(legend.position = "none")

ggplot(d, aes(x = distance, fill = factor(origin))) + 
  geom_histogram() +
  ylab("Number of flights") +
  xlab("Distance") +
  ggtitle("Histogram of distance from each airport")+
  facet_wrap(~ origin, ncol = 1)+
  theme(legend.position = "none")

ggplot(d, aes(x = carrier, fill = factor(origin))) + 
  geom_histogram(stat = "count") +
  xlab("Carrier") +
  ylab("Number of Flights") +
  labs(fill = "origin") +
  ggtitle("Count of flight with different origin")

#Q6. With seed 100 take 3000 random samples from d 

set.seed(100)
d <- nycflights13::flights
d1 <- d[sample(nrow(d), 3000), ]

head(d1)
summary(d1)


#Q7. Plot departure delay v arrival delay
ggplot(d1, aes(x = dep_delay, y = arr_delay, color = factor(origin))) +
  labs(color = "origin") +
  xlab("Departure Delay") +
  ylab("Arrival Delay") +
  geom_point() +
  geom_smooth() +
  ggtitle("Departure delay v arrival delay for n = 3000")

#Q8. Plot distance vs airtime
ggplot(d1, aes(x = distance, y = air_time, color = factor(origin))) +
  labs(color = "origin") +
  xlab("Distance") +
  ylab("Air Time") +
  geom_point() +
  geom_smooth(method = lm) +
  ggtitle("distance v air time for n = 3000")
