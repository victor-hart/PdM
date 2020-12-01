#' Data transforms
#'
#' The function for data transformation. For more details about the
#' parameter arguments, use \code{?transfrom_data}
#'
#' @aliases process_data
#' @param train_df the training dataframe containing multiple multivariate time series formatted using
#' the specific Table Schema, use \code{showDF()} to display schema specification details.
#' @param test_df the test dataframe containing multiple multivariate time series formatted using
#' the specific Table Schema, use \code{showDF()} to display schema specification details.
#' @param method The transform nethod. Possible methods are:
#' \describe{
#'   \item{BoxCox:}{apply a Box-Cox transform, values must be non-zero and positive.}
#'   \item{YeoJohnson:}{apply a Yeo-Johnson transform, like a BoxCox, but values can be negative.}
#'   \item{expoTrans:}{apply a power transform like BoxCox and YeoJohnson.}
#'   \item{zv:}{remove attributes with a zero variance (all the same value).}
#'   \item{nzv:}{remove attributes with a near zero variance (close to the same value).}
#'   \item{center: }{divide values by standard deviation.}
#'   \item{scale:}{subtract mean from values.}
#'   \item{range:}{normalize values.}
#'   \item{pca:}{transform data to the principal components.}
#'   \item{ica:}{transform data to the independent components.}
#'   \item{spatialSign:}{project data onto a unit circle.}
#'   \item{c("center", "scale"):}{standardize data}
#'
#' }
#' @return Returns the transformed training and test datasets
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#' @seealso \code{\link{showDF}}, \code{\link{validate_data}},\code{\link{summarize_data}}
#'
#' @keywords data transform
#'
#' @examples
#' train
#'
#' @export




#' @export
process_data <- function(train_df, test_df, method = "range"){

  # prepare data for transforming
  # for training data
  if ("RUL" %in% colnames(train_df)) {
    origin_variable <- c("id", "RUL")
    origin_train <- train_df[origin_variable]
    trans_train <-  train_df %>%  dplyr::select(-one_of(origin_variable))
  } else {
    origin_train <- train_df["id"]
    trans_train <-  train_df %>%  dplyr::select(-one_of("id"))
  }
 # for test data
  origin_test <- test_df["id"]
  trans_test <- test_df %>%  dplyr::select(-one_of("id"))

  # preprocess
  preprocessParams <- caret::preProcess(trans_train, method = method)

  # transfroming
  transformed_train <- predict(preprocessParams, trans_train)
  transformed_test <- predict(preprocessParams, trans_test)

  # combind data
  train_data <- dplyr::bind_cols(origin_train, transformed_train)
  test_data <- dplyr::bind_cols(origin_test, transformed_test)

  # Check variables with a zero variance
  if (method == "zv") {
    name_var1 <-  colnames(train_df)
    name_var2 <-  colnames(train_data)
    x <- name_var1 %in% name_var2
    name_var <- name_var1[!x]
    message(paste(paste("The following variables with a zero variance is deleted:"),  paste(name_var, collapse = ", ")))
  }

  # Check variables with a near zero variance
  if (method == "nzv") {
    name_var1 <-  colnames(train_df)
    name_var2 <-  colnames(train_data)
    x <- name_var1 %in% name_var2
    name_var <- name_var1[!x]
    message(paste(paste("The following variables with a near zero variance is deleted:"),  paste(name_var, collapse = ", ")))
  }

  return(list(train_data, test_data))
}
