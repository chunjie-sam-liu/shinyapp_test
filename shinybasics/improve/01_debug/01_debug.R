library(shiny)

output$distPlot <- renderPlot({
  x <- faithful[,2]
  bins <- seq(min(x), max(x), length.out = input$bins + 1)
})









