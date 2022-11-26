library(purrr)
library(dplyr)
library(tidyverse)


d1 <- mpg %>% group_by(class)

d1

my_mpg_lms <- function(x){
  main <- group_split(x) %>% map(~lm(cty~displ, data=.))
  class(main) <- "my_mpg_lms"
  names(main) <- unlist(group_keys(x))
  main
}

mods1 <- my_mpg_lms(d1)
mods1

length(mods1)

class(mods1)

names(mods1)

str(mods1[[1]])

str(mods1[[7]])

summary.my_mpg_lms <- function(x){
  cat("The following are the model groups \n")
  cat(names(x))
  cat("Here are the results \n")
  i = 1
  test <- walk2(names(x),x,~{
    cat("Model #", i, 
        "Group", .x, 
        "Obs = ", paste(count(.y$model), "\n"))
    print(summary(.y))
    cat("============================================\n")
    i <<- i+1
  })
}
summary(mods1)

d2 <- mpg %>% group_by(manufacturer)
mods2 <- my_mpg_lms(d2)
names(mods2)

summary(mods2)
