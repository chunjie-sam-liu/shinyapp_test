library(shiny)

ui <- fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      helpText("Create demographic maps with information from the 2010 US Census."),
      
      selectInput(
        inputId = "var",
        label = "Choose a variable to display",
        choices = c(
          "Percent White",
          "Percent Black",
          "Percent Hispanic",
          "Percent Asian"
        ),
        selected = "Percent White"
      ),
      sliderInput(
        inputId = "range",
        label = "Range of interest:",
        min = 0, max = 100, value = c(0,100)
      )
    ),
    mainPanel = mainPanel(
      textOutput("selected_var"),
      textOutput("range_var")
    )
  )
)

server <- function(input, output){
  output$selected_var <- renderText({
    paste("You have selected this", input$var)
    })
  output$range_var <- renderText({
    glue::glue("You have chosen a range that goes from {input$range[1]} to {input$range[2]}")
    })
}

shinyApp(ui = ui, server = server)
