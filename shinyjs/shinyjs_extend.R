library(shiny)
library(shinyjs)


shinyApp(
  ui = fluidPage(
    useShinyjs(),
    extendShinyjs(script = "extend.js"),
    selectInput("col", "Colour: ", c("white", "yellow", "red", "blue", "purple"))
    ),
  server = function(input, output) {
    observeEvent(input$col, {js$pageCol(input$col)})
  }
)

jscode <- "shinyjs.init = function() {$(document).keypress(function(e) { alert('Key pressed: ' + e.which); });}"

shinyApp(
  ui = fluidPage(
    useShinyjs(),
    extendShinyjs(script = jscode),
    "Press any key"
  ),
  server = function(input, output) {}
)


shinyApp(
  ui = fluidPage(
    useShinyjs(),
    extendShinyjs(script = "extend.js"),
    p(id = "name", "My name is Dean"),
    p(id = "sport", "I like soccer"),
    selectInput("col", "Colour:", c("white", "yellow", "red", "blue", "purple")),    
    textInput("selector", "Element", ""),
    actionButton("btn", "Go")
  ),
  server = function(input, output) {
    observeEvent(input$btn, {js$backgroundCol(input$selector, input$col)})
  }
)
