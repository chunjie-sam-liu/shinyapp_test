library(shiny)

ui <- fluidPage(
  selectInput(inputId = "datasetName", label = "Dataset", choices = c("", "pressure", "cars")),
  plotOutput("plot"),
  tableOutput("table")
)

server <- function(input, output) {
  dataset <- reactive({
    req(input$datasetName)
    
    get(x = input$datasetName, pos = "package:datasets", inherits = F)
  })
  
  output$plot <- renderPlot({
    plot(dataset())
  })
  
  output$table <- renderTable({
    head(dataset(), 10)
  })
}

shinyApp(ui = ui, server = server)







