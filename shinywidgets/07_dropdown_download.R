library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  tags$h2("Dropdown Button"),
  br(),
  dropdownButton(
    
    tags$h3("List of Inputs"),
    
    selectInput(inputId = 'xcol',
                label = 'X Variable',
                choices = names(iris)),
    
    selectInput(inputId = 'ycol',
                label = 'Y Variable',
                choices = names(iris),
                selected = names(iris)[[2]]),
    
    sliderInput(inputId = 'clusters',
                label = 'Cluster count',
                value = 3,
                min = 1,
                max = 9),
    
    
    circle = TRUE, status = "danger",
    icon = icon("gear"), width = "300px",
    
    tooltip = tooltipOptions(title = "Click to see inputs !")
  ),
  
  plotOutput(outputId = 'plot1')
)

server <- function(input, output, session) {
  
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
  
}

shinyApp(ui = ui, server = server)











library(shiny)
ui <- shinyUI(fluidPage(
  titlePanel("Download base plot in Shiny - an example"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "var1", label = "Select the X variable", choices = c("Sepal.Length" = 1, "Sepal.Width" = 2, "Petal.Length" = 3, "Petal.Width" = 4)),
      selectInput(inputId = "var2", label = "Select the Y variable", choices = c("Sepal.Length" = 1, "Sepal.Width" = 2, "Petal.Length" = 3, "Petal.Width" = 4), selected = 2),
      radioButtons(inputId = "var3", label = "Select the file type", choices = list("png", "pdf"))
    ),
    mainPanel(
      plotOutput("plot"),
      downloadButton(outputId = "down", label = "Download the plot")
    )
  )
  
))


server <- shinyServer(function(input,output)({
  # x contains all the observations of the x variable selected by the user. X is a reactive function
  x <- reactive({
    iris[,as.numeric(input$var1)]
  })
  # x contains all the observations of the y variable selected by the user. Y is a reactive function
  y <- reactive({
    iris[,as.numeric(input$var2)]
    
  })
  # xl contains the x variable or column name of the iris dataset selected by the user
  xl <- reactive({
    names(iris[as.numeric(input$var1)])
  })
  # yl contains the y variable or column name of the iris dataset selected by the user
  yl <- reactive({
    names(iris[as.numeric(input$var2)])
  })
  
  # render the plot so could be used to display the plot in the mainPanel
  output$plot <- renderPlot({
    plot(x=x(), y=y(), main = "iris dataset plot", xlab = xl(), ylab = yl())
    
  })
  
  # downloadHandler contains 2 arguments as functions, namely filename, content
  output$down <- downloadHandler(
    filename =  function() {
      paste("iris", input$var3, sep=".")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
      if(input$var3 == "png")
        png(file) # open the png device
      else
        pdf(file) # open the pdf device
      plot(x=x(), y=y(), main = "iris dataset plot", xlab = xl(), ylab = yl()) # draw the plot
      dev.off()  # turn the device off
      
    } 
  )
}))
shinyApp(ui, server)


library(shiny)
library(ggplot2)
runApp(list(
  ui = fluidPage(downloadButton('foo')),
  server = function(input, output) {
    plotInput = function() {
      qplot(speed, dist, data = cars)
    }
    output$foo = downloadHandler(
      filename = 'test.png',
      content = function(file) {
        device <- function(..., width, height) {
          grDevices::png(..., width = width, height = height,
                         res = 300, units = "in")
        }
        ggsave(file, plot = plotInput(), device = device)
      })
  }
))
