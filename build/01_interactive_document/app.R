library(shiny)

shinyApp(
  ui = fluidPage(
    sliderInput(inputId = "slider", label = "Slider", min = 1, max = 100, value = 50),
    downloadButton(outputId = "report", label = "Generate report")
  ),
  server = function(input, output) {
    output$report <- downloadHandler(filename = "report.html", content = fucntion(file){
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = T)
    })
  }
)

