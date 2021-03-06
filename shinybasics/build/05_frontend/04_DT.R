library(shiny)
library(DT)

ui <- basicPage(
  h2("The mtcars data"),
  DT::dataTableOutput("mytable")
)

server <- function(input, output) {
  output$mytable <- DT::renderDataTable({
    tibble::rownames_to_column(mtcars) -> .d
    DT::datatable(
      data = .d, 
      filter = "top",
      style = 'bootstrap',
      class = 'table-bordered table-condensed',
      options = list(
        pageLength = 5, 
        autoWidth = TRUE, 
        order = list(list(2, "asc"), list(4, "desc")),
        initComplete = DT::JS(
          "function(settings, json) {",
          "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
          "}")
        )
      ) %>% DT::formatRound(names(.d[-1]), 2)
  })
}
shinyApp(ui = ui, server = server)

# DT options
# https://rstudio.github.io/DT/functions.html
# DT bootstrape
# http://rstudio.github.io/DT/005-bootstrap.html

library(ggplot2)  # for the diamonds dataset

ui <- fluidPage(
  title = "Examples of DataTables",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "diamonds"',
        checkboxGroupInput("show_vars", "Columns in diamonds to show:",
                           names(diamonds), selected = names(diamonds))
      ),
      conditionalPanel(
        'input.dataset === "mtcars"',
        helpText("Click the column header to sort a column.")
      ),
      conditionalPanel(
        'input.dataset === "iris"',
        helpText("Display 5 records by default.")
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("diamonds", DT::dataTableOutput("mytable1")),
        tabPanel("mtcars", DT::dataTableOutput("mytable2")),
        tabPanel("iris", DT::dataTableOutput("mytable3"))
      )
    )
  )
)
server <- function(input, output) {
  
  # choose columns to display
  diamonds2 = diamonds[sample(nrow(diamonds), 1000), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(diamonds2[, input$show_vars, drop = FALSE])
  })
  
  # sorted columns are colored now because CSS are attached to them
  output$mytable2 <- DT::renderDataTable({
    DT::datatable(mtcars, options = list(orderClasses = TRUE))
  })
  
  # customize the length drop-down menu; display 5 rows per page by default
  output$mytable3 <- DT::renderDataTable({
    DT::datatable(iris, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  })
  
}

shinyApp(ui, server)
