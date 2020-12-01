#' R package for predictive maintenance
#'
#'  Contains tools to analyze, visualize multiple multivariate time series,
#'  explore failure modes, and  build predictive maintenance models for IoT.
#'
#'
#' @docType package
#' @name PdM
#' @import ggplot2
#' @import dplyr
#' @import viridis
#' @import skimr
#' @import magrittr
#' @import caret
#' @import keras
#'
#'
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1")  utils::globalVariables()
# see https://github.com/forvis/PdM




