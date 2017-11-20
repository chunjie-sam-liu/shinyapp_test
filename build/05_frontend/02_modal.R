library(shiny)

shinyApp(
  ui = basicPage(
    actionButton(inputId = "show", label = "Show model dialog")
  ),
  server = function(input, output) {
    observeEvent(input$show, {
      showModal(modalDialog(
        title = "Important message", 
        "This is an important message!",
        easyClose = TRUE
      ))
    })
  }
)




# Show Notification -------------------------------------------------------

shinyApp(
  ui = fluidPage(
    actionButton(inputId = "show", label = "Show")
  ),
  server = function(input, output) {
    observeEvent(input$show, {
      showNotification("This is a notification.", type = "error")
    })
  }
)
