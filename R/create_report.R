
#' @export
create_report <-  function(title = "Tes", authors = "Cuong Sai", format = "PDF", output_dir = getwd()) {
  appDir = system.file("report/report.Rmd", package = "PdM")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `PdM`.", call. = FALSE)
  }
  out = rmarkdown::render(appDir, output_format = "html_document", output_dir = output_dir)
}
