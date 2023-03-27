library(tidyverse)
library(kableExtra)
library(kable)


data <- read_csv("output.csv")

data %>%
  knitr::kable(
    format = "html",
    align = "l",
    booktabs = TRUE,
    longtable = TRUE,
    linesep = "",
    #printing the modularilty and word pairs
  ) %>%
  kableExtra::kable_paper(
    position = "center",
    latex_options = c("striped", "repeat_header", "scale_down"),
    stripe_color = "gray!15",
    font_size = 8
  )