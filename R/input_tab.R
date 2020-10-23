#' @title input_tab for the UI
#' 
#' @description Selects the appropriate argument for shiny's selectInput function based on the app module.
#' tabindex = 2 is for "The Spread" page
#' tabindex = 3 is for "The Response" page
#' 
#' @import shiny
#' 
#' @param tabindex argument based on index of the page (example mentioned in description)
#'       
#' @export
input_tab <- function(tabindex) {
  if (tabindex == 2){
  selectInput(inputId = "metric",
              label = "Select metric",
              selected = "deaths",
              choices = c("deaths", "confirmed", "tests", "recovered")
  )
  }
  else if (tabindex == 3){
    selectInput(inputId = "measures",
                label = "Select measure:",
                selected = "testing_policy",
                choices = c("school_closing", "workplace_closing", 
                            "transport_closing", "testing_policy")
    )
  }
  else {
    stop("Invalid input")
  }
}

"input_tab"