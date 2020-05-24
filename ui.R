# Simple Shinny app for creating custom datasets
#for binary classification and clustering
# Author: David Montalván

library(shiny)

# Define UI
shinyUI(fluidPage(
  
  # title
  titlePanel("Create your dataset"),
  
  fluidRow(
    column(4,
    "
    Click in the graph for drawing a point.
    Select the class for changing the color
    ")
  ),
  
  # Side bar panel
    sidebarPanel(
      downloadButton('downloadData', 'Download data')
    ),
  
  #Class button
  radioButtons(
    inputId = 'button_class', label = 'Select a class',
    choices = c('Positive', 'Negative')
    ),
  
  # Show a plot of the generated data
  mainPanel(
     plotOutput("plot", click = "plot_click", height =600, width = 800)
    )
  )
)
