#' Training and Test datasets Validation
#'
#' Checks if the input data is correctly formatted in accordance with the training and test datasets
#'
#' @aliases validate_data
#' @param df dataframe containing multiple multivariate time series formatted using
#' the specific Table Schema, use \code{showDF()} to display schema specification details.
#' @return TRUE if the checks are passed, FALSE otherwise.
#' @details Checks that fc contains necessary column and the composite primary key values are not duplicated.
#' @author Cuong Sai and Maxim Shcherbakov.
#' @seealso \code{\link{showDF}}
#'
#' @examples
#' validate_data(train_data)
#'
#' @export

validate_data <- function(df) {
  # Error handling
  if (!is.data.frame(df)){
    stop("Argument df should be a data frame.")
  }
  if (!sum(is.element(c("id", "timestamp"), colnames(df))) == 2) {
    stop("Check the column names of input data frame. The input data needed in the form of
         a data frame containing columns named 'id', 'timestamp'.")
  }
  cols <- colnames(df)
  s <- sum(startsWith(cols, "s"))
  c <- sum(startsWith(cols, "c"))
  if (s == 0 && c == 0) {
    stop("Check the column names of input data frame. The input data needed in the form of
         a data frame containing columns named starts with 's' for sensors or 'c' for conditions")
  }

  # Finding duplicate records for <id> and <timestamp>
  df_check <- df[, c("id", "timestamp")]

  if (sum(!duplicated(df_check)) != nrow(df_check)) {
    stop(paste(paste("Check the input data frame. The input data frame has duplicate records for the columns
    id and timestamp. Indices of duplicated rows:"), paste(rownames(df_check[duplicated(df_check),]), collapse = ", ")))
  }
  return(TRUE)
}
