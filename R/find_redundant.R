# Remove Redundant Features
# ensure the results are repeatable
#' @export
find_redundant <- function(df, cf = 0.75) {

  # calculate correlation matrix
  correlationMatrix <- cor(df)
  # summarize the correlation matrix
  #print(correlationMatrix)
  # find attributes that are highly corrected (ideally >0.75)
  highlyCorrelated <- caret::findCorrelation(correlationMatrix, cutoff=cf)
  # print indexes of highly correlated attributes
  # Check variables with a near zero variance
  # if (method == "nzv") {
  #   name_var1 <-  colnames(train_df)
  #   name_var2 <-  colnames(train_data)
  #   x <- name_var1 %in% name_var2
  #   name_var <- name_var1[!x]
  #   message(paste(paste("The following variables with a near zero variance is deleted:"),  paste(name_var, collapse = ", ")))
  # }
  name_redundant <- c()
  for (i in highlyCorrelated) {
    name_redundant[i] <- names(df)[i]
  }
  name_redundant<- na.omit(name_redundant)
  name_redundant <- as.character(name_redundant)
  #
  message(paste(paste("The following highly corrected features is removed:"),
                paste(name_redundant, collapse = ", ")))

  # create a new dataset without highly corrected features
  df1 <- df[,-highlyCorrelated]
  return(df1)
}

