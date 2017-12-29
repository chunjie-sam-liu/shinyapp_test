library(shiny)
library(shinyWidgets)
shinyApp(
    ui = fluidPage(
      tags$h1("Click the button"),
      actionButton(inputId = "success", label = "Launch a success sweet alert"),
      receiveSweetAlert(messageId = "successSw")
    ),
    server = function(input, output, session) {
      observeEvent(input$success, {
        sendSweetAlert(session = session, messageId = "successSw", title = "Success !!", text = "All in order", type = "success")
      })
    }
   )
