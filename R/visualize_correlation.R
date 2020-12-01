#' visualize correlations
#'
#' visualize_correlation
#'
#' @param df dataframe containing multiple multivariate time series formatted using
#' the specific Table Schema, use \code{showDF()} to display schema specification details.
#' @param method what type of plot should be drawn. Possible methods are:
#' \describe{
#'   \item{circle:}{for circle}
#'   \item{square:}{for square}
#'   \item{ellipse:}{for ellipse}
#'   \item{number:}{for number}
#'   \item{pie:}{for pie}
#'   \item{shade:}{for shade}
#'   \item{color:}{for color}
#' }
#'
#' @export
#'

visualize_correlation <- function(df, method="circle",...){

  correlations <- cor(df)
  table <- correlations
  plot <- corrplot::corrplot(correlations, method=method,...)
  out <- list(table, plot)
  return(out)
}
