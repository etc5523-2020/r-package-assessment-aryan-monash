library(tibble)
x <- as.tibble(c(1:3))
y <- as.tibble(c(1:3))

test_that("Test select_metric()",{
  expected <- reactive({
    data <- filtered_data()
    data %>%
      rename(metric = input$metric)
  })
  actual <- select_metric(filtered_data,input)
  expect_equal(expected, actual)
})
