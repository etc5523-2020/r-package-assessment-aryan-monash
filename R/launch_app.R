#' @title Launch_app
#' 
#' @description Launches the embedded shiny app in a new window.
#'   
#'    
#' @export
launch_app <- function() {
  appDir <- system.file("shiny-covid19viz", "app.R", package = "covid19viz")
  if (appDir == "") {
    stop("Something went wrong. Try re-installing `covid19viz`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}

"launch_app"