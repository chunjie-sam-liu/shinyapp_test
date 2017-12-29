ui <- fluidPage(
  titlePanel("Reactivity"),
  sidebarLayout(
      sidebarPanel = sidebarPanel(
        textInput(inputId = "caption", label = "Caption:", value = "Data summary"),
        selectInput(inputId = "dataset", label = "Choose a dataset:", choices = c("rock", "pressure", "cars")),
        numericInput(inputId = "obs", label = "Number of observations to view:", value = 10)
      ),
      mainPanel = mainPanel(
        h3(textOutput("caption", container = span)),
        verbatimTextOutput("summary"),
        tableOutput("view")
      )
  )
)
