#Student Id : 22223696
#Name : Smitesh Patil

set.seed(100)
CX101 <- rnorm(20,45,8)
CX102 <- rnorm(20,65,8)
CX103 <- rnorm(20,85,10)
CX104 <- rnorm(20,45,10)
CX105 <- rnorm(20,60,5)

summary(CX101)
summary(CX102)
summary(CX103)
summary(CX104)
summary(CX105)

col_names <- paste0("CX10", 1:5)
row_names <- paste0("Student_", 1:20)

mat <- matrix(c(CX101, CX102, CX103, CX104, CX105), ncol = 5)

colnames(mat) <- col_names
rownames(mat) <- row_names

### Matrix with na values for invalid data

res1 <- apply(mat, c(1,2), function(x){
   if(x > 100 || x < 0){
     x <- NA
   }else{
     x <- x
   }
})

print(res1)

###Matrix with Mean value of column replaced by NA

res2 = apply(res1, 2, function(x){
  ifelse(is.na(x) == T, mean(x, na.rm= T), x)
  })

print(res2)

mean <- apply(res2, 1, mean)
range <- apply(res2, 1, function(x){
  x <- max(x) - min(x)
})

## adding new columns mean and range
mat_with_mean <- cbind(res2, mean)
mat_with_range <- cbind(mat_with_mean, range)


## retriveing maximum mean value
max <- apply(mat_with_range, 2, max)['mean']
max_mean <- mat_with_range[mat_with_range[, 'mean'] == max, ,drop= F]
