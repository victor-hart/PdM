#' Input data frame (DF) Specification
#'
#' Displays DF
#'
#' @aliases showDF
#' @details The \href{https://forvis.github.io/our-publications/1.pdf}{Time Series Table Schema} is designed to store time series
#' actuals across many time series. The fovision R-package uses the TSTS format in
#' its functions API to pass actuals as dataframes.
#'
#' The TSTS format makes it possible to keep actuals in external storage, to select
#' relevant data subsets and to slice-and-dice forecast data for further processing.
#' @author Cuong Sai and Maxim Shcherbakov.
#'
#' @examples
#' showDF()
#'
#' @export


showDF <- function(){
  vignette("df", "PdM")
}
