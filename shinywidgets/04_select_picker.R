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
    ),
    multiInput(
      inputId = "Id010", label = "Countries :", 
      choices = NULL, choiceNames = lapply(seq_along(countries), function(i) tagList(tags$img(src = flags[i], width = 20, height = 15), countries[i])), choiceValues = countries)
  )
)

server <- function(input, output, session){}

shinyApp(ui = ui, server = server)

# Multi select ------------------------------------------------------------


library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  multiInput(
    inputId = "id", label = "Fruits :",
    choices = c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya"),
    selected = "Banana", width = "350px"
  ),
  verbatimTextOutput(outputId = "res"),
  radioButtons(inputId = "up", label = "Update", choices = c("none", "random", "all"))
)

server <- function(input, output, session) {
  output$res <- renderPrint({input$id})
  observeEvent(input$up, {
    choices <- c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                 "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya")
    if (input$up == "none") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", selected = character(0))
    } else if (input$up == "random") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", selected = sample(choices, sample(1:2)))
    } else if (input$up == "all") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", selected = choices)
    }
  }, ignoreInit = TRUE)
}

shinyApp(ui = ui, server = server)
