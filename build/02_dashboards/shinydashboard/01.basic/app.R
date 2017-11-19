library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem(text = "Widgets", tabName = "widgets", icon = icon("th"))
    )
  ),
  dashboardBody(
    # Box need to be put in a row or column
    fluidRow(
      box(plotOutput("plot1", height = 250)),
      box(
        title = "Controls", 
        sliderInput(inputId = "slider", label = "Number of ovbservations:", min = 1, max = 100, value = 50)
      )
    )
  )
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
