# Install these pacakges using install.package("Package Name")
library(shiny)
library("COVID19")
library(tidyverse)
library(scales)
library(plotly)
library(leaflet)
library(shinythemes)
library(DT)

# Data Wrangling
data  <- covid19(verbose = FALSE)

top_covid <- data %>%
    filter(date == "2020-10-01") %>%
    arrange(desc(confirmed)) %>%
    head(50)

top_covid_resp <- data %>%
    filter(id %in% unique(top_covid$id)) %>%
    pivot_longer(cols = school_closing:stringency_index, names_to = "measures", values_to = "measure_value")


# User interface
ui <- navbarPage("COVID-19", theme = shinytheme("flatly"),
                 tabPanel("About",
                          titlePanel("COVID-19 Visualising App"),
                          p("ETC5523 - Communicating with Data"),
                          sidebarLayout(
                              sidebarPanel(
                                  h2("The Creator"),
                                  br(),
                                  h4("Aryan Jain"),
                                  p("31418600"),
                                  br(),
                                  h4("Monash University"),
                                  p("Business Analytics"),
                                  br(),
                                  br(),
                                  br(),
                                  br(),
                                  p("Social Profiles:"),
                                  a("Github", 
                                    href = "https://github.com/aryan-monash"), "|",
                                  a("LinkedIn", 
                                    href = "https://www.linkedin.com/in/jainaryan/"), "|",
                                  a("LinkedIn", 
                                    href = "https://www.kaggle.com/jaryan")
                              ),
                              mainPanel(
                                  h1("Introducing the App"),
                                  p("This is COVID-19 exploration app designed with ", 
                                    strong("Shiny "), 
                                    "R package."),
                                  br(),
                                  p("This app explores the spread of COVID-19 across various nations and also compares the measures taken by these country to combat the virus. This easy to use and lightweight app produces simple visualisations with an easy to use User Interface that is both minimal and functional."),
                                  br(),
                                  h2("Features"),
                                  br(),
                                  h4(strong("The Spread")),
                                  p("- Explore cases, deaths, recovery and testing over a selected date range and countries."),
                                  h4(strong("The Response")),
                                  p("- Compare responses by the government for user-selectable parameters and date input.")
                              )
                          )
                 ),
                 tabPanel("The Spread",
                          sidebarLayout(
                              sidebarPanel(
                                  h2("User Inputs"),
                                  br(),
                                  selectizeInput(inputId = "administrative_area_level_1",
                                                 label = "Select Country",
                                                 choices = unique(data$administrative_area_level_1),
                                                 selected = "United States",
                                                 options = list(maxItems = 4)
                                  ),
                                  p("Type to add a country"),
                                  br(),
                                  input_tab(2),
                                  p("Select metric for comparison"),
                                  br(),
                                  dateRangeInput(
                                      inputId = "selected_dates",
                                      label = "Date Range:",
                                      start = "2020-03-01",
                                      end = "2020-09-01",
                                      min = min(data$date), 
                                      max = max(data$date)),
                                  p("Select time period"),
                                  br(),
                                  br(),
                                  h2("Description"),
                                  p("This page gives a visual representation of how the virus expanded in the selected nations based on various metrics such as deaths, cases count, recoveries and testing. There is also a Table panel that shows the exact count of the selected metric on any date."),
                              ),
                              mainPanel(
                                  tabsetPanel(type = "tabs",
                                              tabPanel("Plot", plotlyOutput("count_plot")),
                                              tabPanel("Table", dataTableOutput("table"))
                                  ),
                                  br(),
                                  p(strong("X-axis")," : Time period selected for analysis"),
                                  p(strong("Y-axis")," : Count of the selected metric"),
                                  br(),
                                  p("Click on", strong("Table "), "panel to look at the data.")
                              )
                          )
                 ),
                 tabPanel("The Response",
                          sidebarLayout(
                              sidebarPanel(
                                  h2("User Inputs"),
                                  br(),
                                  input_tab(3),
                                  p("Select the type of response"),
                                  br(),
                                  dateInput(
                                      inputId = "date",
                                      label = "Select Date:",
                                      value = "2020-09-01"),
                                  p("Select the date on which the response is to be measured"),
                                  br(),
                                  br(),
                                  h2("Description"),
                                  p("This page displays the responses by health administration of various countries based on several user-selectable measures on any specific period of time in 2020.")
                              ),
                              mainPanel(
                                  leafletOutput("leaf_plot"),
                                  br(),
                                  p("(Legend Upper bound exclusive)"),
                                  h4("Schools, Workplace and Transport"),
                                  p("- 0: No measures"), 
                                  p("- 1: Recommend closing"),
                                  p("- 2: Require closing"),
                                  p("- 3: Require closing all levels"),
                                  h4("Testint Policy"),
                                  p("- 0: No testing policy"), 
                                  p("- 1: testing symptomatic essential workers"),
                                  p("- 2: testing all symptomatic patients"),
                                  p("- 3: open public testing")
                              )
                          )
                 ),
                 tabPanel("References",
                          tabsetPanel(type = "tabs",
                                      tabPanel("R Packages", 
                                               h4("DT"),
                                               p("Yihui Xie, Joe Cheng and Xianying Tan (2020). DT: A Wrapper of the JavaScript Library
  'DataTables'. R package version 0.15. https://CRAN.R-project.org/package=DT"),
                                               h4("Leaflet"),
                                               p("Joe Cheng, Bhaskar Karambelkar and Yihui Xie (2019). leaflet: Create Interactive Web
  Maps with the JavaScript 'Leaflet' Library. R package version 2.0.3.
  https://CRAN.R-project.org/package=leaflet"),
                                               h4("plotly"),
                                               p("C. Sievert. Interactive Web-Based Data Visualization with R, plotly, and shiny. Chapman
  and Hall/CRC Florida, 2020."),
                                               h4("Scales"),
                                               p("Hadley Wickham and Dana Seidel (2020). scales: Scale Functions for Visualization. R
  package version 1.1.1. https://CRAN.R-project.org/package=scales"),
                                               h4("Shiny"),
                                               p("Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny:
  Web Application Framework for R. R package version 1.5.0.
  https://CRAN.R-project.org/package=shiny"),
                                               h4("ShinyThemes"),
                                               p("Winston Chang (2018). shinythemes: Themes for Shiny. R package version 1.1.2.
  https://CRAN.R-project.org/package=shinythemes"),
                                               h4("Tidyverse"),
                                               p("Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software,
  4(43), 1686, https://doi.org/10.21105/joss.01686")
                                      ),
                                      tabPanel("Covid-19 Data", 
                                               h4("COVID-19 HUB"),
                                               p('Guidotti, E., Ardia, D., (2020), "COVID-19 Data Hub", Journal of Open Source Software 5(51):2376, doi: 10.21105/joss.02376.

'))
                          )
                          
                 )
)


# Server
server <- function(input, output, session) {
  
  # The Spread
  selected_country <- reactive({
    data %>%
      filter(administrative_area_level_1 %in% input$administrative_area_level_1)
  })
  
  selected_date <- reactive({
    data <- selected_country()
    start_date <- input$selected_dates[1]
    end_date <- input$selected_dates[2]
    data %>% 
      filter(between(date, start_date, end_date))
  })
  select_metric(filtered_data = selected_date, input = input)
  
    # The Response
    selected_measure <- reactive({
        top_covid_resp %>%
            filter(measures == input$measures) %>%
            filter(date == input$date)
    })

    
    # The Spread Panel
    output$count_plot <- renderPlotly({

        output_plot <- selected_metric()
        plot_ly(output_plot, x = ~date, y = ~metric) %>%
            add_lines(linetype = ~administrative_area_level_1)
    })
    
    output$table <- renderDataTable({
        output_table <- selected_metric() %>%
            select("id", "date", "metric")
        datatable(output_table, style = 'bootstrap', options = list(pageLength = 10))
    })
    
    # The Response Panel
    output$leaf_plot <- renderLeaflet({
        output_plot <- selected_measure()
        pal <- colorBin(palette = "viridis", domain = output_plot$measure_value, bins = c(0,1,2,3,4))
        
        leaflet(output_plot) %>%
            addTiles() %>%
            addCircleMarkers(~longitude, 
                             ~latitude, 
                             label = ~administrative_area_level_1, 
                             radius = ~measure_value*3,
                             color = ~pal(measure_value),
                             layerId = ~administrative_area_level_1) %>%
            addLegend("topright", 
                      pal = pal, 
                      values = ~measure_value, 
                      title = "Measure", 
                      opacity = 1
            )
    })
}

# Run the app
shinyApp(ui = ui, server = server)
