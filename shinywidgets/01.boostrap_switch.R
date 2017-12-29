library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  fluidRow(
    switchInput(inputId = "bsSwitch")
  ),
  
  fluidRow(
    switchInput(
      inputId = "bsSwitch", label = "Afficher ?",
      onLabel = "Oui", offLabel = "Non",
      onStatus = "success", offStatus = "danger"
    )
  ),
  
  fluidRow(
    materialSwitch(inputId = "maSwitch", label = "Label", value = TRUE, status = "primary")
  )
)

server <- function(input, output, session){}

shinyApp(ui = ui, server = server)
