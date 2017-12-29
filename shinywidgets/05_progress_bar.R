library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  fluidRow(
    progressBar(id = "progress01", value = 50),
    sliderInput(inputId = "slider", label = "hello", value = 50,  min = 0, max = 100)
  ),
  fluidRow(
    progressBar(id = "progress02", value = 50, total = 100, status = "success", display_pct = TRUE, striped = TRUE, title = "Indicateur")
  )
)

server <- function(input, output, session){
  observe({
    updateProgressBar(session = session, id = "progress01", value = input$slider)
    updateProgressBar(session = session, id = "progress02", value = input$slider, total = 100)
  })
  
}

shinyApp(ui = ui, server = server)




library("shiny")
 library("shinyWidgets")

 ui <- fluidPage(
   tags$b("Default"), br(),
   progressBar(id = "pb1", value = 50),
   sliderInput(inputId = "up1", label = "Update", min = 0, max = 100, value = 50)
 )

 server <- function(input, output, session) {
   observeEvent(input$up1, {
     updateProgressBar(session = session, id = "pb1", value = input$up1)
   })
 }

 shinyApp(ui = ui, server = server)
