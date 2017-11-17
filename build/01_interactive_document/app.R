library(shiny)

shinyApp(
  ui = fluidPage(
    sliderInput(inputId = "slider", label = "Slider", min = 1, max = 100, value = 50),
    downloadButton(outputId = "report", label = "Generate report")
  ),
  server = function(input, output) {
    output$report <- downloadHandler(
      filename = "report.doc", 
      content = function(file){
        tempReport <- file.path(tempdir(), "report.Rmd")
        file.copy("report.Rmd", tempReport, overwrite = T)
        params <- list(n = input$slider)
        
        rmarkdown::render(
          input = tempReport, 
          output_file = file, 
          params = params, 
          envir = new.env(parent = globalenv()))
        }
      )
  }
)

