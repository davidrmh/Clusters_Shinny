library(shiny)
shinyServer(function(input, output) {
  
  #Variable 'point' stores the location
  #and class of each point
  point <- reactiveValues(
    
    x_cord = c(),
    y_cord = c(),
    class = NULL,
    
    #Variables with prefix new_
    #are used as auxiliary ones
    #for creating the plot only
    new_x = NULL,
    new_y = NULL,
    new_class = NULL,
    
    #This table will store the dataset
    table = NULL
  )
  
  #Observe the click event in the plot
  observeEvent(input$plot_click, {
    
    #Append the new data
    point$x_cord <- c(point$x_cord, input$plot_click$x )
    point$y_cord <- c(point$y_cord, input$plot_click$y )
    point$class <- c(point$class, switch(input$button_class,
                          Positive = 'blue',
                          Negative = 'red') )
    
    #For creating the plot
    point$new_x <- input$plot_click$x
    point$new_y <- input$plot_click$y
    point$new_class <- switch(input$button_class,
                              Positive = 'blue',
                              Negative = 'red')
  })
  
  #Draw the points
  output$plot <- renderPlot({
      plot(0,0, cex = 0,
           main = "Draw the points",
           xaxt='n', xlab = '',
           yaxt ='n', ylab ='')
      points(point$x_cord, point$y_cord, pch = 21, cex = 1.2, bg = point$class)
      points(point$new_x, point$new_y, pch = 21, cex = 1.2, bg = point$new_class)
  })
  
  #To download the data
  output$downloadData <- downloadHandler(
    filename = "cluster.csv",
    content = function(filename){
      
      #Create a vector with the classes
      df_classes <- rep(0, length(point$class))
      df_classes[point$class == 'blue'] <- 1
      df_classes[point$class == 'red'] <- -1
      
      #create the table
      df_classes <- rep(0, length(point$class))
      df_classes[point$class == 'blue'] <- 1
      df_classes[point$class == 'red'] <- -1
      point$table <- data.frame(x = point$x_cord, y = point$y_cord, class = df_classes)
      
      #saves the file
      write.csv(point$table, file = filename, row.names = FALSE)
    }
  )
  
})
