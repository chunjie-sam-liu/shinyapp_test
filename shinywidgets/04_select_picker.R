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
jsCode <- '
shinyjs.switch = function(){
  
  setTimeout(function(){ 
  console.log($("#id").val()); 
  $("#id").change();
}, 100);

};
'
ui <- fluidPage(
  shinyjs::useShinyjs(),
  extendShinyjs(text = jsCode),
  multiInput(
    inputId = "id", label = "Fruits :",
    choices = c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya"),
    selected = NULL, width = "350px",
    choiceNames = c("Selected", "unselected")
  ),
  switchInput(
    inputId = "up", label = "Analysis", value = FALSE,
    onLabel = "All", offLabel = "None", size = "large", offStatus = "danger"
  ),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {
  output$res <- renderPrint({input$id})
  observeEvent(input$up, {
    choices <- c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                 "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya")
    
    if (input$up == FALSE) {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", selected = character(0))
    }
    if (input$up == TRUE) {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", selected = choices)
      shinyjs::js$switch()
    }
  }, ignoreInit = TRUE)
}

shinyApp(ui = ui, server = server)

ui <- fluidPage(
  switchInput(inputId = "somevalue", offStatus = "danger"),
  verbatimTextOutput("value")
)
server <- function(input, output) {
  output$value <- renderPrint({ input$somevalue })
}
shinyApp(ui, server)



