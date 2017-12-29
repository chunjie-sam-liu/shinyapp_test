library(shiny)

ui <- pageWithSidebar(
  headerPanel = headerPanel("Miles Per Gallon"),
  sidebarPanel = sidebarPanel(
    selectInput(inputId = "variable", label = "Variable:", choices = c("Cylinders" = "cyl", "Transmission" = "am", "Gears" = "gear"), selected = "gear"),
    checkboxInput(inputId = "outliers", label = "Show outliers", value = TRUE)
  ),
  mainPanel = mainPanel(
    h3(textOutput("caption")),
    plotOutput("mpgPlot")
  )
)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against mpg ----
  # and only exclude outliers if requested
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData,
            outline = input$outliers,
            col = "#75AADB", pch = 19)
  })
  
}

shinyApp(ui = ui, server = server) -> app



