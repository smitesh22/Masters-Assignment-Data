conv_df_to_list <- function(dataframe){
  output = list()
  df_names <- names(dataframe)
  for (i in 1:nrow(dataframe)){
    output <- append(output, list(as.list(dataframe[i, ])))
  }
  names(output) <- paste0("R-", 1:length(output))
  
  return(output)
}

output <- conv_df_to_list(head(Formaldehyde))

str(output)


