library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  header = dashboardHeader(),
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Dashboard", icon = icon("dashboard"), tabName = "dashboard"),
      menuItem(text = "Widgets", icon = icon("th"), tabName = "widgets")
    )
  ),
  body = dashboardBody(
    # First tab content
    tabItems(
      tabItem(
        tabName = "dashboard",
        fluidRow(
          box(plotOutput(outputId = "plot1", height = 250)),
          
          box(title = "Controls", sliderInput(inputId = "slider", label = "Number of observations:", min = 1, max = 100, value = 50))
        )
      ),
    
    # Second tab content
      tabItem(
        tabName = "widgets",
        h2("Widgets tab content")
      )
    )
  ),
  title = "Test",
  skin = "purple"
)


server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui = ui, server = server)
