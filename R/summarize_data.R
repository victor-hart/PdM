#' Extract summary statistics for input data frame
#'
#' This function used to summarize the input data frame
#'
#' @aliases summarize_data
#' @param df dataframe containing multiple multivariate time series formatted using
#' the specific Table Schema, use \code{showDF()} to display schema specification details.
#' @return a data frame containing the by variables and the statistical summaries
#' @details \code{summarize_data()} is an alternative to \code{summary()}, quickly providing
#' a broad overview of a data frame. It handles data of all types, dispatching a different set
#' of summary functions based on the types of columns in the data frame.
#'
#'
#' @seealso \code{\link{showDF}}, \code{\link{validate_data}}
#'
#' @examples
#' summary_data(train_data)
#' summary_data(test_data)
#' @export

summarize_data <- function(df) {

  if (validate_data(df)) {

    data_rows <- dim(df)[1]
    data_cols <- dim(df)[2]

    # Create statistics
    var <- colnames(df)
    complete <- apply(df, 2, function(x){length(x)})
    missing <- apply(df, 2, function(x){sum(is.na(x))})

    mean <- apply(df, 2, function(x){round(mean(x, na.rm = TRUE), digits = 3)})
    type <- apply(df, 2, function(x){class(x)})
    median <- apply(df, 2, function(x){round(median(x, na.rm = TRUE), digits = 3)})
    min <- apply(df, 2, function(x){round(min(x, na.rm = TRUE), digits = 3)})
    max <- apply(df, 2, function(x){round(max(x, na.rm = TRUE), digits = 3)})
    Qu25 <- apply(df, 2, function(x){round(quantile(x, 0.25, na.rm = TRUE), digits = 3)})
    Qu75 <- apply(df, 2, function(x){round(quantile(x, 0.75, na.rm = TRUE), digits = 3)})
    skew <- apply(df, 2, function(x) {round(e1071::skewness(x), digits = 3)})

    #  not to use exponential notation
    mean <- format(mean, scientific = FALSE)
    median <- format(median, scientific = FALSE)
    min <- format(min, scientific = FALSE)
    max <- format(max, scientific = FALSE)
    Qu25 <- format(Qu25, scientific = FALSE)
    Qu75 <- format(Qu75, scientific = FALSE)


    # Create output data frame
    df_out <- data.frame(variable = var, type, complete, missing, min, quartile_25 = Qu25, mean, median,quartile_75 = Qu75,max, skew)
    row.names(df_out) <- NULL
    # print
    cat("+++ Summary statistics +++\n")
    cat("==============================\n")
    cat("- Number of observations:", data_rows , "\n")
    cat("- Number of variables:", data_cols, "\n")
    cat("==============================\n")
    df_out
  } else {
    stop("Check the column names of input data frame. The input data needed in the form of
         a data frame containing columns named 'id', 'timestamp', starts with 's' for sensors or 'c' for conditions.")
  }
}
