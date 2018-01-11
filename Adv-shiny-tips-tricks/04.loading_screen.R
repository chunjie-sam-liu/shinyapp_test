library(shiny)
library(shinyjs)

appCSS <- "
#loading-content {
position: absolute;
background: #000000;
opacity: 0.9;
z-index: 100;
left: 0;
right: 0;
height: 100%;
text-align: center;
color: #FFFFFF;
}
"

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    actionButton("button", "Click me"),
    div(id = "hello", "Hello!")
  )
)

ui <- fluidPage(
  useShinyjs(),
  inlineCSS(appCSS),
  
  # Loading message
  div(
    id = "loading-content",
    h2("Loading...")
  ),
  
  # The main app code goes here
  hidden(
    div(
      id = "app-content",
      p("This is a simple example of a Shiny app with a loading screen.")
    )
  )
)

server <- function(input, output) {
  # Simulate work being done for 1 second
  Sys.sleep(1)
  
  # Hide the loading message when the rest of the server function has executed
  hide(id = "loading-content", anim = TRUE, animType = "fade")    
  show("app-content")
}

shinyApp(ui, server)

library(shiny)
library(shinyjs)

load_data <- function() {
  Sys.sleep(2)
  hide("loading_page")
  show("main_content")
}

ui <- fluidPage(
  useShinyjs(),
  div(
    id = "loading_page",
    h1("Loading...")
  ),
  hidden(
    div(
      id = "main_content",
      "Data loaded, content goes here"
    )
  )
)

server <- function(input, output, session) {load_data()}

shinyApp(ui = ui, server = server)

library(shiny)
library(shinydashboard)
library(shinyjs)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    actionButton(inputId = "btn_data", label = "Download"),
    conditionalPanel(condition = "output.setupComplete",
                     box( title = "box1" ),
                     box( title = "box2" ),
                     box( title = "boc3" )
    ),
    conditionalPanel(condition = "!output.setupComplete",
                     box( title = "loading"))
  )
)

server <- function(input, output) { 
  
  rv <- reactiveValues()
  rv$setupComplete <- FALSE
  
  ## simulate data load
  observe({
    
    if(input$btn_data){
      
      df <- data.frame(id = seq(1,200),
                       val = rnorm(200, 0, 1))
      
      ## Simulate the data load
      Sys.sleep(5)
      ## set my condition to TRUE
      rv$setupComplete <- TRUE
    }
    
    ## the conditional panel reads this output
    output$setupComplete <- reactive({
      return(rv$setupComplete)
    })
    outputOptions(output, 'setupComplete', suspendWhenHidden=FALSE)
    
  })
}

shinyApp(ui, server)

shinyUI(pageWithSidebar(
  headerPanel("Action button example"),
  sidebarPanel(actionButton("button1", "New samples")),
  mainPanel(plotOutput("plot"))
)) -> ui

shinyServer(function(input, output) {
  output$plot <- reactivePlot(function() {
    input$button1
    hist(rnorm(20))
  })
}) -> server

shinyApp(ui = ui, server = server)



# use shinyjs init for loading screen
appCSS <- "
#loading-content {
position: absolute;
background: #000000;
opacity: 0.9;
z-index: 100;
left: 0;
right: 0;
height: 100%;
text-align: center;
color: #FFFFFF;
}
"
library(shiny)
library(shinydashboard)
library(shinyjs)
jscode <- "shinyjs.init = function() {
  $(document).keypress(function(e) { alert('Key pressed: ' + e.which); });
}"
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    useShinyjs(), extendShinyjs(text = jscode),
    inlineCSS(appCSS),
    actionButton("button", "Click me"),
    div(id = "hello", "Hello!")
  )
)

server <- function(input, output) {
  observeEvent(input$button, {
    Sys.sleep(2)
    toggle("hello")
  })
}

shinyApp(ui, server)


# Loading screen for dashboad ---------------------------------------------

library(shinydashboard)

dsbh <- dashboardHeader(title = "Basic dashboard")
dsbs <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", tabName = "widgets", icon = icon("th"))
  )
)
dsbb <- dashboardBody(
  tabItems(
    # First tab content
    tabItem(tabName = "dashboard",
            fluidRow(
              box(plotOutput("plot1", height = 250)),
              
              box(
                title = "Controls",
                sliderInput("slider", "Number of observations:", 1, 100, 50)
              )
            )
    ),
    
    # Second tab content
    tabItem(tabName = "widgets",
            h2("Widgets tab content")
    )
  )
)
dsbp <- dashboardPage(header = dsbh, sidebar = dsbs, body = dsbb)



ui <- fluidPage(
  useShinyjs(),
  inlineCSS(appCSS),
  
  # Loading message
  div(
    id = "loading-content",
    h2("Loading...")
  ),
  
  # The main app code goes here
  hidden(
    div(
      id = "app-content",
      dsbp
    )
  )
)

server <- function(input, output) {
  Sys.sleep(2)
  
  # Hide the loading message when the rest of the server function has executed
  hide(id = "loading-content", anim = TRUE, animType = "fade")    
  show("app-content")
  
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)
