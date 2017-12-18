library(shiny)
library(shinyjs)
ui <- fluidPage(
  useShinyjs(),
  actionButton("button", "click me"),
  textInput("text", "Text")
)
server <- function(input, output) {
  observeEvent(input$button, {
    toggle("text")
  })
}

shinyApp(ui, server)


shinyApp(
  ui = fluidPage(
    shinyjs::useShinyjs(),
    shinyjs::inlineCSS(list(.big = "font-size: 2em")),
    div(id = "myapp", h2("shinyjs demo"), 
        checkboxInput("big", "Bigger text", FALSE),
        textInput("name", "Name", ""),
        shinyjs::hidden(
          div(id = "advanced", numericInput("age", "Age", 30),textInput("company", "Company", ""))
          ),
        p("Timestamp: ", span(id = "time", date()), a(id = "update", "Update", href = "#")),
        p(a(id = "toggleAdvanced", "Show/hide advanced info")),
        actionButton("reset", "Reset form"),
        actionButton("submit", "Submit"))
  ),
  server = function(input, output) {
    observeEvent(input$submit, { shinyjs::alert("Thank you!") })
    observeEvent(input$reset, {shinyjs::reset("myapp")})
    shinyjs::onclick("update", shinyjs::html("time", date()))
    shinyjs::onclick("toggleAdvanced", shinyjs::toggle(id = "advanced", anim = TRUE))
    observe({
      # if (is.null(input$name) || input$name == "") {
      #   shinyjs::disable("submit")
      # } else {
      #   shinyjs::enable("submit")
      # }
      shinyjs::toggleClass("myapp", "big", input$big)
      shinyjs::toggleState("submit", !is.null(input$name) && input$name != "")
    })
  }
)
