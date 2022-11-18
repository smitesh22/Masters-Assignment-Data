library(tidyverse)


d1 <- mpg %>%
  group_by(class) %>%
  nest()

my_mpg_lms = function (x){
  x %>% mutate(
    lm = map(data, ~lm(displ ~ cty ,data = .))
  )
}

mods1 <- my_mpg_lms(d1)

names(mods1)