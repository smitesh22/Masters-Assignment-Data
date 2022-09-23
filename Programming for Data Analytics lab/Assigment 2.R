conv_df_to_list <- function(dataframe){
  output = list()
  df_names <- names(dataframe)
  for (i in 1:nrow(dataframe)){
    output <- append(output, list(as.list(dataframe[i, ])))
  }
  names(output) <- paste0("R-", 1:length(output))
  
  return(output)
}


names(mtcars)

length(mtcars[["mpg"]])

Formaldehyde

c_1 <- conv_df_to_list(Formaldehyde)
str(c_1)

mtcars1 <- head(mtcars)
mtcars1

c_2 <- conv_df_to_list(mtcars1)
str(c_2)