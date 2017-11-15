library(shiny)
library(maps)
library(mapproj)

# Load data ----
counties <- readRDS("data/counties.rds")

# Source helper functions -----
source("helpers.R")

# User interface ----
ui <- fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
               information from the 2010 US Census."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Percent White", "Percent Black",
                              "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
      ),
    
    mainPanel(plotOutput("map"))
  )
  )

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    args <- switch(
      input$var,
      "Percent White" = list(counties$white, "darkgreen", "% White"),
      "Percent Black" = list(counties$black, "black", "% Black"),
      "Percent Hispanic" = list(counties$hispanic, "darkorange", "% Hispanic"),
      "Percent Asian" = list(counties$asian, "darkviolet", "% Asian")
    )
    args$min <- input$range[1]
    args$max <- input$range[2]
    do.call(percent_map, args)
  })
}

# Run app ----
shinyApp(ui, server)

# Shinyapps.io deployment -------------------------------------------------

# Test for sharing through github -----------------------------------------


library(shiny)
runGitHub("chunjie-sam-liu/shinyapp-test")
shiny::runGitHub("shiny-examples", "rstudio", subdir = "001-hello")

# Gist was block by the wall ----------------------------------------------
runGist("adcd899afbaccef760818b8d016f85e2")


# Deployment on the shinyapps.io ------------------------------------------
rsconnect::setAccountInfo(name='chunjie-sam-liu',
                          token='<TOKEN>',
                          secret='<SECRET>')
rsconnect::deployApp('path/to/your/app')
