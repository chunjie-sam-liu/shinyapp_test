server <- function(input, output){
 output$plot <- renderPlot({
   input$goPlot
   
   dat <- data.frame(x = numeric(0), y = numeric(0))
   
   withProgress(message = "Making plot", value = 0, {
     n <- 10
     for (i in 1:n) {
       dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
       
       incProgress(1 / n, detail = paste("Doing part", i))
       
       Sys.sleep(0.1)
     }
   })
   plot(dat$x, dat$y)
 }) 
}
ui <- shinyUI(basicPage(
  plotOutput('plot', width = "300px", height = "300px"),
  actionButton('goPlot', 'Go Plot')
))

shinyApp(ui = ui, server = server)

server <- function(input, output, session){
  output$plot <- renderPlot({
    input$goPlot
    
    dat <- data.frame(x = numeric(0), y = numeric(0))
    
    progress <- shiny::Progress$new()
    
    on.exit(progress$close())
    progress$set(message = "Making Plot", value = 0)
    n <- 10
    for (i in 1:n){
      dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
      
      progress$inc(1 / n, detail = paste("Doing part", i))
      
      Sys.sleep(0.1)
    }
    plot(dat$x, dat$y)
  })
}
shinyApp(ui = ui, server = server)


# A more complex Progress example -----------------------------------------

compute_data <- function(updateProgress = NULL) {
  # Create 0-row data frame which will be used to store data
  dat <- data.frame(x = numeric(0), y = numeric(0))
  
  for (i in 1:10) {
    Sys.sleep(0.25)
    
    # Compute new row of data
    new_row <- data.frame(x = rnorm(1), y = rnorm(1))
    
    # If we were passed a progress update function, call it
    if (is.function(updateProgress)) {
      text <- paste0("x:", round(new_row$x, 2), " y:", round(new_row$y, 2))
      updateProgress(detail = text)
    }
    
    # Add the new row of data
    dat <- rbind(dat, new_row)
  }
  
  dat
}


server <- function(input, output) {
  output$table <- renderTable({
    input$goTable
    
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "Computing data", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    # Compute the new data, and pass in the updateProgress function so
    # that it can update the progress indicator.
    compute_data(updateProgress)
  })
}

ui <- shinyUI(basicPage(
  tableOutput('table'),
  actionButton('goTable', 'Go table')
))

shinyApp(ui = ui, server = server)

