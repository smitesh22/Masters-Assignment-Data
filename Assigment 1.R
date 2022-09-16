set.seed(100)

(temps <- round(rnorm(100, mean = 7, sd = 4), digits = 1))

(names(temps) <- paste0("D-", 1:100))

head(temps)

tail(temps)

sum(temps > mean(temps))

max_temp <- max(temps)
names(temps)[temps == max(temps)]

min(temps)
names(temps)[temps == min(temps)]

(w_warnings <- ifelse(temps <= 4, "Warning", "Normal"))

temps[40:44]
w_warnings[40:44]

sum(ifelse(w_warnings == "Warning", TRUE, FALSE))

names(w_warnings)[w_warnings == "Warning"]

(tab <- table(w_warnings))

