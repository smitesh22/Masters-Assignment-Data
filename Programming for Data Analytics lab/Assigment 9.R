library(tidyverse)
d1 <- mpg %>%
  group_by(class)