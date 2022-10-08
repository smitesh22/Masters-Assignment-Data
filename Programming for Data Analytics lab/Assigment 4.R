set.seed(100)
CX101 <- rnorm(20,45,8)
CX102 <- rnorm(20,65,8)
CX103 <- rnorm(20,85,10)
CX104 <- rnorm(20,45,10)
CX105 <- rnorm(20,60,5)

summarise(CX101)
summarise(CX102)
summarise(CX103)
summarise(CX104)
summarise(CX105)

col_names <- paste0("CX10", 1:5)
row_names <- paste0("Student_", 1:20)

mat <- matrix(c(CX101, CX102, CX103, CX104, CX105), ncol = 5)

colnames(mat) <- col_names
rownames(mat) <- row_names

mat_with_na = apply(mat, c(1,2), function(x){
   if(x > 100){
     x <- NA
   }else{
     x <- x
   }
})

#mean_val <- mean(mat_with_na[, "CX103"], na.rm = TRUE)


mat_with_avg = apply(mat_with_na, c(1, 2), function(x){
  col.means <- apply(mat_with_na, 2, mean, na.rm=T)
  if(is.na(x)){
    x <- col.means[3]
  }else{
    x <- x
  }
})

print(mat_with_avg)

mean <- apply(mat, 1, mean)
range <- apply(mat, 1, function(x){
  x <- max(x) - min(x)
})

mat_with_mean <- cbind(mat_with_avg, mean)
mat_with_range <- cbind(mat_with_mean, range)


max <- apply(mat_with_range, 2, max)['mean']
mat_with_range[mat_with_range[, 'mean'] == max, ,drop= F]