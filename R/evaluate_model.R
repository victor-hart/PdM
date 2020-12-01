#' Model Evaluation
#'
#' The function evaluates...
#'
#' @aliases evaluate_model
#' @param observed observed...
#' @param predicted predicted...
#
#' @return Vector of different metrics...
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#' @seealso \code{\link{showDF}}, \code{\link{validate_data}},\code{\link{summarize_data}}
#'
#' @keywords evaluation
#'
#'
#' @export



evaluate_model <- function(observed, predicted) {
  predicted <- as.vector(predicted)
  observed <- as.vector(observed)
  mean_observed <- mean(observed)
  se <- (observed - predicted)^2
  ae <- abs(observed - predicted)
  sem <- (observed - mean_observed)^2
  aem <- abs(observed - mean_observed)
  mae <- mean(ae)
  rmse <- sqrt(mean(se))
  rae <- sum(ae) / sum(aem)
  rse <- sum(se) / sum(sem)
  rsq <- 1 - rse
  # metrics <- c("Mean Absolute Error" = mae,
  #              "Root Mean Squared Error" = rmse,
  #              "Relative Absolute Error" = rae,
  #              "Relative Squared Error" = rse,
  #              "Coefficient of Determination" = rsq)
  metrics <- data.frame(metric = c("Mean Absolute Error", "Root Mean Squared Error",  "Relative Absolute Error",
                                   "Relative Squared Error", "Coefficient of Determination"),
                        value =  c(mae, rmse, rae, rse, rsq))
  return(metrics)
}
