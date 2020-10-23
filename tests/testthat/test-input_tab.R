tabindex <- 2

test_that("Test input_tab()",{
  expected <- function(tabindex) {
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
  actual <- input_tab(tabindex)
  expect_equal(expected(tabindex), actual)
})
