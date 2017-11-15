library(shiny)

ui <- fluidPage(
  title = "Test for shiny App",
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      h1("Installation"),
      p("Shiny is available on CRAN, so you can install it in the usual way from your R console:"),
      code("install.packages(\"shiny\")"),
      br(),
      img(src = "imgs/rstudio.png"),
      p("Shiny is a product of",span("RStudio", style="color:blue"))
    ),
    mainPanel(
      h1("Introducing Shiny"),
      p("Shiny is a new package from RStudio that makes it",
        em("incredibly"), 
        "easy to build interactive web application with R."),
      br(),
      p("For an introction and live examples, visit the",
        a(href = "http://shiny.rstudio.com/tutorial/written-tutorial/lesson2/", "Shiny homepage.")),
    br(),
    h2("Features"),
    p("- Build useful web applications with only a few lines of code-no JavaScript required."),
    p("- Shiny applications are automatically 'live' in the same way that ",
      strong("spreadsheets"),
      " are live. Outputs change instantly as users modify inputs, without requiring a reload of the browser.")
  )
)
)

server <- function(input, output){
 
  
}

shinyApp(ui = ui, server = server)
