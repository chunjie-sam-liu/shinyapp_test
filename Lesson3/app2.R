library(shiny)

ui <- fluidPage(
  titlePanel("censusVis"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      helpText("Ceate demographic maps with information from the 2010 US Census."),
      selectInput(
        inputId = "var",
        label = h5("Choose a variable to display"),
        choices = list(
          "Percent White" = 1,
          "Percent Black" = 2,
          "Percent Hispanic" = 3,
          "Percent Asian" = 4
        ),
        selected = 4
      ),
      sliderInput(
        inputId = "slider",
        label = "Range of interest:",
        min = 0, max = 100,
        value = c(0, 100)
      )
    ),
    mainPanel = mainPanel("")
  )
)

server = function(input, output){
  
}

shinyApp(ui = ui, server = server)
