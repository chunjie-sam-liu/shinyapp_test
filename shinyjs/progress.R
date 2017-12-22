library(shiny)
server <- function(input, output) {
  output$plot <- renderPlot({
    input$goPlot # Re-run when button is clicked

    # Create 0-row data frame which will be used to store data
    dat <- data.frame(x = numeric(0), y = numeric(0))

    withProgress(message = "Making plot", value = 0, {
      # Number of times we'll go through the loop
      n <- 10

      for (i in 1:n) {
        # Each time through the loop, add another row of data. This is
        # a stand-in for a long-running computation.
        dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))

        # Increment the progress bar, and update the detail text.
        incProgress(1 / n, detail = paste("Doing part", i))

        # Pause for 0.1 seconds to simulate a long computation.
        Sys.sleep(0.1)
      }
    })

    plot(dat$x, dat$y)
  })
}

ui <- shinyUI(basicPage(
  plotOutput("plot", width = "300px", height = "300px"),
  actionButton("goPlot", "Go plot")
))

shinyApp(ui = ui, server = server)


compute_data <- function(updateProgress = NULL) {
  # Create 0-row data frame which will be used to store data
  dat <- data.frame(x = numeric(0), y = numeric(0))

  for (i in 1:10) {
    Sys.sleep(0.25)

    # Compute new row of data
    new_row <- data.frame(x = rnorm(1), y = rnorm(1))

    # If we were passed a progress update function, call it
    if (is.function(updateProgress)) {
      text <- paste0("x:", round(new_row$x, 2), " y:", round(new_row$y, 2))
      updateProgress(detail = text)
    }

    # Add the new row of data
    dat <- rbind(dat, new_row)
  }

  dat
}


server <- function(input, output) {
  output$table <- renderTable({
    input$goTable

    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "Computing data", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())

    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }

    # Compute the new data, and pass in the updateProgress function so
    # that it can update the progress indicator.
    compute_data(updateProgress)
  })
}

ui <- shinyUI(basicPage(
  tableOutput("table"),
  actionButton("goTable", "Go table")
))

shinyApp(ui = ui, server = server)


# dashborad box -----------------------------------------------------------
ibrary(shiny)

# A dashboard body with a row of infoBoxes and valueBoxes, and two rows of boxes
body <- dashboardBody(

  # infoBoxes
  fluidRow(
    infoBox("Orders", uiOutput("orderNum2"), "Subtitle", icon = icon("credit-card")),
    infoBox("Approval Rating", "60%", icon = icon("line-chart"), color = "green", fill = TRUE),
    infoBox("Progress", uiOutput("progress2"), icon = icon("users"), color = "purple")
  ),

  # valueBoxes
  fluidRow(
    valueBox(uiOutput("orderNum"), "New Orders", icon = icon("credit-card"), href = "http://google.com"),
    valueBox(
      tagList("60", tags$sup(style = "font-size: 20px", "%")), "Approval Rating",
      icon = icon("line-chart"), color = "green"
    ),
    valueBox(htmlOutput("progress"), "Progress", icon = icon("users"), color = "purple")
  ),

  # Boxes
  fluidRow(
    box(
      status = "primary",
      sliderInput("orders", "Orders", min = 1, max = 2000, value = 650),
      selectInput(
        "progress", "Progress",
        choices = c(
          "0%" = 0, "20%" = 20, "40%" = 40, "60%" = 60, "80%" = 80,
          "100%" = 100
        )
      )
    ),
    box(
      title = "Histogram box title",
      status = "warning", solidHeader = TRUE, collapsible = TRUE,
      plotOutput("plot", height = 250)
    )
  ),

  # Boxes with solid color, using `background`
  fluidRow(
    # Box with textOutput
    box(
      title = "Status summary",
      background = "green",
      width = 4,
      textOutput("status")
    ),

    # Box with HTML output, when finer control over appearance is needed
    box(
      title = "Status summary 2",
      width = 4,
      background = "red",
      uiOutput("status2")
    ),

    box(
      width = 4,
      background = "light-blue",
      p("This is content. The background color is set to light-blue")
    )
  )
)

server <- function(input, output) {
  output$orderNum <- renderText({
    prettyNum(input$orders, big.mark = ",")
  })

  output$orderNum2 <- renderText({
    prettyNum(input$orders, big.mark = ",")
  })

  output$progress <- renderUI({
    tagList(input$progress, tags$sup(style = "font-size: 20px", "%"))
  })

  output$progress2 <- renderUI({
    paste0(input$progress, "%")
  })

  output$status <- renderText({
    paste0(
      "There are ", input$orders,
      " orders, and so the current progress is ", input$progress, "%."
    )
  })

  output$status2 <- renderUI({
    iconName <- switch(input$progress,
      "100" = "ok",
      "0" = "remove",
      "road"
    )
    p("Current status is: ", icon(iconName, lib = "glyphicon"))
  })


  output$plot <- renderPlot({
    hist(rnorm(input$orders))
  })
}

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    body
  ),
  server = server
)
