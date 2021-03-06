
library(shiny)
library(parallel)
library(ggplot2)

cl <- makeCluster(detectCores() - 1, "PSOCK")
sim <- function(x, y, z) {
  c(rnorm(1, mean = x), rnorm(1, mean = y), rnorm(1, mean = z))
}

shinyApp(
  ui = shinyUI(bootstrapPage(
    numericInput("x", "x", 10, min = 1, max = 100),
    numericInput("y", "y", 10, min = 1, max = 100),
    numericInput("z", "z", 10, min = 1, max = 100),
    plotOutput("plot")
  )),

  server = shinyServer(function(input, output, session) {
    output$plot <- renderPlot({
      x <- input$x
      y <- input$y
      z <- input$z
      clusterExport(
        cl, varlist = c("x", "y", "z", "sim"),
        envir = environment()
      )

      mat <- t(parSapply(cl, 1:1000, function(i) {
        sim(x, y, z)
      }))
      ggplot(
        as.data.frame(mat),
        aes(x = V1, y = V2, col = cut(V3, breaks = 10))
      ) + geom_point()
    })
  })
)

# Can not use shiny parrallel for now.
# https://github.com/rstudio/shiny/issues/1843
