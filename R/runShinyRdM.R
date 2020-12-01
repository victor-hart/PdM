#' @title Run shinyPdM
#'
#' @description
#' Run a local instance of shinyPdM.
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
    stop("Could not find example directory. Try re-installing `shinyPdM`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
