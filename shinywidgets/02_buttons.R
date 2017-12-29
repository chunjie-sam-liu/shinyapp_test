library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  fluidRow(
    checkboxGroupButtons(inputId = "checkBtn", label = "Make a choice :", choices = c("Choice A", "Choice B", "Choice C"))
  ),
  
  fluidRow(
    radioGroupButtons(inputId = "radioBtn", label = "Make a choice :", choices = c("Choice A", "Choice B", "Choice C"))
  ),
  fluidRow(
    checkboxGroupButtons(
      inputId = "somevalue", label = "Faites votre choix :", 
      choices = c("Choice A", "Choice B", " Choice C", "Choice D"), 
      justified = TRUE, status = "primary",
      checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
    )
  )
)

server <- function(input, output, session){}

shinyApp(ui = ui, server = server)
