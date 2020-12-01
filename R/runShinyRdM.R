#' @title Run shinyPdM
#'
#' @description
#' Run shinyPdM.
#'
#' @param ... [\code{any}]\cr
#'   Additional arguments passed to shiny's
#'   \code{runApp()} function.
#' @examples
#' \dontrun{
#'   runShinyPdM()
#' }
#' @import shiny
#' @import shinythemes
#' @export

runShinyPdM = function(...) {
  appDir = system.file("shinyPdM", package = "PdM")
  if (appDir == "") {
    stop("Could not find shinyPdM", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
