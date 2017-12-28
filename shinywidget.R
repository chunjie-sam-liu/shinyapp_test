library(shiny)
library(shinyWidgets)
ui <- fluidPage(
  checkboxGroupButtons(
    inputId = "somevalue", label = "Make a choice :", 
    choices = c("Choice A", "Choice B", " Choice C", "Choice D"), 
     
    status = "primary",
    justified = TRUE,
    checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
    direction = "vertical",
    individual = TRUE
  ),
  switchInput(inputId = "id", value = TRUE)
)

shinyApp(ui = ui, server = function(input, output, session){})

