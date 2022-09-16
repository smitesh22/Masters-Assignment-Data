set.seed(100)

(temps <- round(rnorm(100, mean = 7, sd = 4), digits = 1))

(names(temps) <- paste0("D-", 1:100))

head(temps)

tail(temps)

sum(temps > mean(temps))

names[max(temps)]

min(temps)

