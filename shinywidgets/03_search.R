library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  fluidRow(
    searchInput(
      inputId = "searchBar", 
      label = "Votre recherche :", 
      placeholder = "Appuyez sur 'enter' pour valider", 
      btnSearch = icon("search", lib = "glyphicon"), 
      btnReset = icon("remove", lib = "glyphicon"), 
      width = "100%"
    )
  )
)

server <- function(input, output, session){}

shinyApp(ui = ui, server = server)
