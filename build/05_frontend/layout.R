shinyUI(fluidPage(
  titlePanel("Hello Shiny!"),
  
  sidebarLayout(
    position = 'right',
    sidebarPanel = sidebarPanel(
      sliderInput(inputId = "obs", label = "Bumber of observations:", min = 1, max = 1000, value = 500)
    ),
    mainPanel = mainPanel(plotOutput("distPlot"))
  )
))




ui <- shinyUI(fluidPage(
  titlePanel("hello shiny!"),
  fluidRow(
    column(4, wellPanel(sliderInput(inputId = "obs", label = "Number of observations:", min = 1, max =1000, value = 500))),
    column(8, plotOutput("distPlot"))
  )
))

server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    hist(x = rnorm(10000), breaks = input$obs)
  })
}

shinyApp(ui = ui, server = server)


library(shiny)
library(ggplot2)

dataset <- diamonds
ui <- shinyUI(
  fluidPage(
    title = "Diamond Explorer",
    plotOutput('plot'),
    br(),
    fluidRow(
      column(
        width = 3,
        h4("Diamonds Explorer"),
        sliderInput(inputId = "sampleSize", label = "Sample Size",  min = 1, max = nrow(dataset), value = min(1000, nrow(dataset))),
        br(),
        checkboxInput(inputId = "jitter", label = "Sample Size"),
        checkboxInput(inputId = "smooth", label = "Smooth")
      ),
      column(
        width = 4,
        offset = 1,
        selectInput(inputId = "x", label = "X", choices = names(dataset)),
        selectInput(inputId = "y", label = "Y", choices = names(dataset)[[2]]),
        selectInput(inputId = "color", label = "Color", choices = c('None', names(dataset)))
      ),
      column(
        width = 4,
        selectInput(inputId = "facet_row", label = "Facet Row", c(None = ".", names(dataset))),
        selectInput(inputId = "facet_col", label = "Facet Column", c(None = ".", names(dataset)))
      )
    )
    
  )
)
server <- function(input, output, session){}
shinyApp(ui = ui, server = server)


shinyUI(
  fluidPage(
    title = titlePanel("Tabsets"),
    
    sidebarLayout(
      sidebarPanel = sidebarPanel(),
      mainPanel = mainPanel(
        tabsetPanel(
          tabPanel(title = "Plot", plotOutput('plot')),
          tabPanel(title = "Summary", verbatimTextOutput('summary')),
          tabPanel(title = "Table", tableOutput('table'))
        )
        )
    )
  )
) -> ui

shinyApp(ui = ui, server = server)

shinyUI(fluidPage(
  title = titlePanel("Application Title"),
  
  navlistPanel(
    "Heder A", 
    tabPanel("Component 1"),
    tabPanel("Component 2"),
    "Header B", 
    tabPanel("Component 3"),
    tabPanel("Component 4"),
    "-----",
    tabPanel("Component 5")
  )
  
)) -> ui
shinyApp(ui = ui, server = server)

shinyUI(
  navbarPage(title = "My Application", tabPanel("Component 1"), tabPanel("Component 2"), tabPanel("Component 3"))
)

shinyUI(
  navbarPage(
    title = "My Application",
    tabPanel("Component 1"),
    tabPanel("Component 2"),
    navbarMenu(
      title = "More",
      tabPanel("Sub-Component 1"),
      tabPanel("Sub-Component 2")
    )
  )
) -> ui
shinyApp(ui = ui, server = server)



