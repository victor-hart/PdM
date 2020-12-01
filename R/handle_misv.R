#' Handling Missing Values
#'
#' Imputation and Removing Data
#'
#' @aliases handle_misv
#' @param df the input dataframe containing multiple multivariate time series formatted using
#' the specific Table Schema with missing values, use \code{showDF()} to display schema specification details.
#' @param  method the method for handling missing values. Possible methods are:
#' \describe{
#'   \item{omit:}{removes the rows containing any missing values}
#'   \item{mean:}{for point graphs (scatter plots)}
#'   \item{median:}{for both line and point graphs}
#'   \item{mod:}{for box plots}
#'   \item{h:}{for histogram}
#'   \item{hf:}{for histograms of the healthy vs failing sensor Values}
#'  }
#' @return A new data frame without missing values
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#'
#' @keywords missing values
#'
#' @examples
#' \dontrun{
#' new_data <- handle_misv(data, method  = "omit")
#' new_data <- handle_misv(data, method  = "mean")
#' new_data <- handle_misv(data, method  = "median")
#' }
#'
#' @export



handle_misv <- function(df, method) {

# Removing
  if (method == "omit") {
    row_na <- which(!complete.cases(df))
    df <- na.omit(df)
    if (length(row_na) != 0) {
      message(paste(paste("The following rows containing missing values:"),  paste(row_na, collapse = ", ")))
    }
  }

# knnImprute
  if (method == "median"){
    # check missing values
    row_na <- which(!complete.cases(df))
    if (length(row_na) != 0) {
      message(paste(paste("The following rows containing missing values:"),  paste(row_na, collapse = ", ")))
    }
    pPmI <- caret::preProcess(df, method = 'medianImpute')
    df <- predict(pPmI, df)
  }

#bagImprute

  if (method == "bag") {
    # check missing values
    row_na <- which(!complete.cases(df))
    if (length(row_na) != 0) {
      message(paste(paste("The following rows containing missing values:"),  paste(row_na, collapse = ", ")))
    }

    pPbI <- caret::preProcess(df, method = 'bagImpute')
    df <- predict(pPbI, df)
  }

# Mean
  if (method == "mean"){
    # check missing values
    row_na <- which(!complete.cases(df))
    if (length(row_na) != 0) {
      message(paste(paste("The following rows containing missing values:"),  paste(row_na, collapse = ", ")))
    }
    for(i in 1:ncol(df)) {
      data[ , i][is.na(df[ , i])] <- mean(df[ , i], na.rm = TRUE)
    }
  }
# Median
  if (method == "knn"){
    # check missing values
    row_na <- which(!complete.cases(df))
    if (length(row_na) != 0) {
      message(paste(paste("The following rows containing missing values:"),  paste(row_na, collapse = ", ")))
    }
    pPknnI <- caret::preProcess(df, method = 'knnImpute')
    df <- predict(pPknnI, df)

  }

# mode
  if (method == "mod") {
    # check missing values
    row_na <- which(!complete.cases(df))
    if (length(row_na) != 0) {
      message(paste(paste("The following rows containing missing values:"),  paste(row_na, collapse = ", ")))
    }
    # Create function for mode calculation
    Mode <- function (x, na.rm) {
      xtab <- table(x)
      xmode <- names(which(xtab == max(xtab)))
      if (length(xmode) > 1) xmode <- ">1 mode"
      return(xmode)
    }

    for (var in 1:ncol(df)) {
      if (class(df[,var])=="numeric") {
        df[is.na(df[,var]),var] <- mean(df[,var], na.rm = TRUE)
      } else if (class(df[,var]) %in% c("character", "factor")) {
        df[is.na(df[,var]),var] <- Mode(df[,var], na.rm = TRUE)
      }
    }
  }

  return(df)
}
