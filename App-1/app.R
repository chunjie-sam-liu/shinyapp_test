library(shiny)

# Define UI
ui <- fluidPage(
  # Title ----
  title = "hell",
  titlePanel("title panel"),
  
  sidebarLayout(
    sidebarPanel = sidebarPanel(),
    mainPanel = mainPanel(
      h1("First level title"),
      h2("Second level title"),
      h3("Third level title"),
      h4("Fourth level title"),
      h5("Fifth level title"),
      h6("Sixth level title")
    ),
    position = "right"
  ) 
)


# Define server logic -----------------------------------------------------



server <- function(input, output){

}

shinyApp(ui = ui, server = server)
