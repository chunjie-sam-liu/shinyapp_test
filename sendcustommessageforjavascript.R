ui <- shinyUI(pageWithSidebar(
  headerPanel("Send Javascript test"),
  sidebarPanel(
    numericInput("controller", "Controller:", min = 1, max = 20, value = 15),
    br()
  ),
  mainPanel(
    
    div(
      "The text below is set directly via Javascript and JQuery:",
      p(id = "target")
    ),
    
    # Add a message handler that simply evaluates the message as Javascript
    tags$head(tags$script(HTML('
                               Shiny.addCustomMessageHandler("jsCode",
                               function(message) {
                               eval(message.value);
                               }
                               );
                               ')))
    )
    ))
server <- shinyServer(function(input, output, session) {
  observe({
    js_string <- sprintf('$("#target").text("Value is %d");', input$controller)
    session$sendCustomMessage(type='jsCode', list(value = js_string))
  })
})

shinyApp(ui = ui, server = server)
