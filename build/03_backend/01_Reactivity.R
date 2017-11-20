library(shiny)
ui <- pageWithSidebar(
  headerPanel = headerPanel("Click the button"),
  sidebarPanel = sidebarPanel(
    sliderInput(inputId = "obs", label = "Number of observations:", min = 0, max = 1000, value = 500),
    actionButton(inputId = 'goButton', "GO!")),
  mainPanel = mainPanel(plotOutput('distPlot'))
)


server <- function(input, output) {

  output$distPlot <- renderPlot({
    if (input$goButton == 0) return()
    
    input$goButton
    
    dist <- isolate(rnorm(input$obs))
    hist(dist)
  })
}

shinyApp(ui = ui, server = server)
