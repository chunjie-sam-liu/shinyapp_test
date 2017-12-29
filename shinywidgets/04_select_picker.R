library(shiny)
library(shinyWidgets)
data("world.cities", package = "maps")
library("dplyr")
fr <- world.cities %>% filter(country.etc == "France") %>% top_n(n = 20, wt = pop)
ui <- fluidPage(
  fluidRow(
    pickerInput(
      inputId = "picker", 
      label = "Choisissez une ou plusieurs ville(s)", 
      choices = fr$name,
      options = list(
        `selected-text-format` = "count > 5",
        `count-selected-text` = "{0} villes sélectionnées",
        `actions-box` = TRUE,
        `deselect-all-text` = "Tous désélectionner",
        `select-all-text` = "Tous sélectionner"
      ), 
      choicesOpt = list(subtext = paste(format(fr$pop, big.mark = " "), "habitants")),
      multiple = TRUE
    )
  )
)

server <- function(input, output, session){}

shinyApp(ui = ui, server = server)
