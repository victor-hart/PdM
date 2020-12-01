#' Remaining useful life calculation
#'
#' Generates the remaining useful life (RUL) colum for training data
#'
#' @aliases calculate_rul
#' @param df a training dataframe containing multiple multivariate time series formatted using
#' the specific Table Schema, use \code{showDF()} to display schema specification details.
#' @return a new training data frame with rul column
#'
#'
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#'
#' @keywords Remaining useful life
#' @examples
#' train_data <- calculate_rul(train_data)
#' @export

calculate_rul <- function(df) {
  df <- df %>% dplyr::group_by(id) %>% dplyr::mutate(RUL = max(timestamp) - timestamp) %>% ungroup()
  return(df)
}
