library(shiny)
ui <- bootstrapPage(
  h3("URL componets"),
  verbatimTextOutput("urlText"),
  h3("Parsed query string"),
  verbatimTextOutput("queryText")
)

server <- function(input, output, session){
  output$urlText <- renderText({
    print(session)
    paste(sep = "",
          "protocol: ", session$clientData$url_protocol, "\n",
          "hostname: ", session$clientData$url_hostname, "\n",
          "pathname: ", session$clientData$url_pathname, "\n",
          "port: ",     session$clientData$url_port,     "\n",
          "search: ",   session$clientData$url_search,   "\n"
    )
  })
  output$queryText <- renderText({
    query <- parseQueryString(session$clientData$url_search)
    paste(names(query), query, sep = "=", collapse = ", ")
  })
}
shinyApp(ui = ui, server = server)




ui <- pageWithSidebar(
  headerPanel("Shiny Client Data"),
  sidebarPanel(
    sliderInput("obs", "Number of observations:",
                min = 0, max = 1000, value = 500)
  ),
  mainPanel(
    h3("clientData values"),
    verbatimTextOutput("clientdataText"),
    plotOutput("myplot")
  )
)

server <- function(input, output, session) {
  # Store in a convenience variable
  cdata <- session$clientData
  
  # Values from cdata returned as text
  output$clientdataText <- renderText({
    cnames <- names(cdata)
    
    allvalues <- lapply(cnames, function(name) {
      paste(name, cdata[[name]], sep = " = ")
    })
    paste(allvalues, collapse = "\n")
  })
  
  # A histogram
  output$myplot <- renderPlot({
    hist(rnorm(input$obs), main = "Generated in renderPlot()")
  })
}

shinyApp(ui, server)

