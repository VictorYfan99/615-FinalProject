#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(mapsapi)
library(leaflet)
library(tidyverse)
library(dplyr)

Transport<- c("Bus", "Light Rail", "Heavy Rail")
Time<- bs_week %>% distinct(hr_week$start_time_sec)
Stop<- bs_week %>% distinct(time_point_id)

key1<- "AIzaSyAVxYHwxp4qUeSU7QhbSbDnNmLXuWqAfIk"

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("MA Transit"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("Transport", "Which transport do you want to?",Transport),
          br(),
          selectInput("Stop", "Which stop do you start?",Stop),
          br(),
          selectInput("Stop", "Which stop do you end?",Stop),
        ),

        # Show a plot of the generated distribution
        mainPanel(
          type = "tabs",
          tabPanel("Map",leafletOutput("map")),
          tabPanel("Table",tableOutput("table"))
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$gmap <- renderGoogle_map({
    google_map(key = key1,
               location = c(),
               zoom = 10,
               search_box = TRUE,
               scale_control = TRUE,
               height = 1000) %>%
      add_traffic()
  })
    output$table <- renderTable({data()})
}

# Run the application 
shinyApp(ui = ui, server = server)

