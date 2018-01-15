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



shinyApp(
  ui = fluidPage(
    useShinyjs(),  # Set up shinyjs
    p(id = "date", "Click me to see the date"),
    p(id = "coords", "Click me to see the mouse coordinates"),
    p(id = "disappear", "Move your mouse here to make the text below disappear"),
    p(id = "text", "Hello")
  ),
  server = function(input, output) {
    onclick("date", alert(date()))
    onclick("coords", function(event) { alert(event) })
    onevent("mouseenter", "disappear", hide("text"))
    onevent("mouseleave", "disappear", show("text"))
  }
)


library(shiny)
shinyApp(
  ui = fluidPage(
    shinyjs::useShinyjs(),
    shinyjs::inlineCSS(list(.big = "font-size: 2em")),
    div(id = "myapp",
        h2("shinyjs demo"),
        checkboxInput("big", "Bigger text", FALSE),
        textInput("name", "Name", ""),
        a(id = "toggleAdvanced", "Show/hide advanced info", href = "#"),
        shinyjs::hidden(
          div(id = "advanced",
              numericInput("age", "Age", 30),
              textInput("company", "Company", "")
          )
        ),
        p("Timestamp: ",
          span(id = "time", date()),
          a(id = "update", "Update", href = "#")
        ),
        actionButton("submit", "Submit"),
        actionButton("reset", "Reset form")
    )
  ),
  
  server = function(input, output) {
    observe({
      shinyjs::toggleState("submit", !is.null(input$name) && input$name != "")
    })
    
    shinyjs::onclick("toggleAdvanced",
                     shinyjs::toggle(id = "advanced", anim = TRUE))    
    
    shinyjs::onclick("update", shinyjs::html("time", date()))
    
    observe({
      shinyjs::toggleClass("myapp", "big", input$big)
    })
    
    observeEvent(input$submit, {
      shinyjs::alert("Thank you!")
    })
    
    observeEvent(input$reset, {
      shinyjs::reset("myapp")
    })    
  }
)


library(shiny)
library(shinyjs)

jsCode <- '
shinyjs.backgroundCol = function(params) {
var defaultParams = {
id : null,
col : "red"
};
params = shinyjs.getParams(params, defaultParams);

var el = $("#" + params.id);
el.css("background-color", params.col);
}'

shinyApp(
  ui = fluidPage(
    useShinyjs(),
    extendShinyjs(text = jsCode),
    p(id = "name", "My name is Dean"),
    p(id = "sport", "I like soccer"),
    selectInput("col", "Colour:",
                c("white", "yellow", "red", "blue", "purple")),    
    textInput("selector", "Element", ""),
    actionButton("btn", "Go")
  ),
  server = function(input, output) {
    observeEvent(input$btn, {
      js$backgroundCol(input$selector, input$col)
    })
  }
)
