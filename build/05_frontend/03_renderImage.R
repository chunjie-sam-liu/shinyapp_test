library(shiny)

ui <- pageWithSidebar(
  headerPanel = headerPanel("renderImage example"),
  
  sidebarPanel = sidebarPanel(
    sliderInput(inputId = "obs", label = "Number of observations", min = 0, max = 1000, value = 500)
  ),
  mainPanel = mainPanel(imageOutput('myImage'))
)


server <- function(input, output){
  output$myImage <- renderImage({
    outfile <- tempfile(fileext = ".png")
    
    png(outfile, width = 400, height = 300)
    hist(rnorm(input$obs), main = "Generated in renderImage()")
    dev.off()
    
    list(src = outfile, contentType = "image/png", width = 400, height = 300, alt = "This is alternative")
  }, deleteFile = T)
}
shinyApp(ui, server)
