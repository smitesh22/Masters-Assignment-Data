set.seed(100)

(temps <- round(rnorm(100, mean = 7, sd = 4), digits = 1))

names(temps) <- paste0("D-", 1:100)

head(temps)

tail(temps)


gt_mean<- sum(temps > mean(temps))
cat("1. Number of days with temperature greater than mean :", gt_mean)

max_temp <- max(temps)


cat("2. Max temp was ", max(temps), " on day ", names(temps)[temps == max(temps)]) 

cat("3. Min temp was ", min(temps), " on day ", names(temps)[temps == min(temps)])


w_warnings <- ifelse(temps <= 4, "Warning", "Normal")

print("4. Create parallel vecotor warning with values 'warning' and 'normal' : ")
temps[40:44]
w_warnings[40:44]

cat("5. Number of days warning were issued : ", 
    sum(ifelse(w_warnings == "Warning", TRUE, FALSE)))

print("6. Days when warning was issued")
names(w_warnings)[w_warnings == "Warning"]

print("7. Warnings in tabular format")
(tab <- table(w_warnings))

print("8.Use of rle function")
rle_encoded <- rle(w_warnings)

cat("Maximum days without warning : ",
    max(rle_encoded$lengths[rle_encoded$values == "Normal"]))

cat("Maxium days with warning : ",
    max(rle_encoded$lengths[rle_encoded$values == "Warning"]))
