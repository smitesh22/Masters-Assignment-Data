set.seed(100)

(temps <- round(rnorm(100, mean = 7, sd = 4), digits = 1))

names(temps) <- paste0("D-", 1:100)

head(temps)

tail(temps)

# Gt mean

sum(temps > mean(temps))

max_temp <- max(temps)


cat("Max temp was ", max(temps), " on ", names(temps)[temps == max(temps)]) 

cat("Min temp was ", min(temps), " on ", names(temps)[temps == min(temps)])


w_warnings <- ifelse(temps <= 4, "Warning", "Normal")

temps[40:44]
w_warnings[40:44]

cat("Number of days warning were issude : ", 
    sum(ifelse(w_warnings == "Warning", TRUE, FALSE)))

names(w_warnings)[w_warnings == "Warning"]

(tab <- table(w_warnings))

rle_encoded <- rle(w_warnings)

cat("Maximum days without warning : ",
    max(rle_encoded$lengths[rle_encoded$values == "Normal"]))

cat("Maxium days with warning : ",
    max(rle_encoded$lengths[rle_encoded$values == "Warning"]))
