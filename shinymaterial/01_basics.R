library(shiny)
library(shinymaterial)
ui <- material_page(
  title = "Basic Page",
  tags$h1("Page Content")
)

server <- function(input, output, session) {}

shiny::shinyApp(ui = ui, server = server)


# dashboard ---------------------------------------------------------------

ui <- material_page(
  title = "Basic Page + Side-Nav with Tabs",
  nav_bar_fixed = TRUE,
  material_side_nav(
    fixed = TRUE,
    material_side_nav_tabs(
      side_nav_tabs = c(
        "Example Side-Nav Tab 1" = "example_side_nav_tab_1",
        "Example Side-Nav Tab 2" = "example_side_nav_tab_2"
      ),
      icons = c("cast", "insert_chart")
    )
  ),
  material_side_nav_tab_content(
    side_nav_tab_id = "example_side_nav_tab_1",
    tags$h1("First Side-Nav Tab Content")
  ),
  material_side_nav_tab_content(
    side_nav_tab_id = "example_side_nav_tab_2",
    tags$h1("Second Side-Nav Tab Content")
  )
)
shinyApp(ui, server)

# Tab and side nav --------------------------------------------------------

ui <- material_page(
  title = "Basic Page + Side-Nav + Tabs",
  # Place side-nav in the beginning of the UI
  material_side_nav(
    fixed = FALSE,
    tags$h3("Side-Nav Content")
  ),
  # Define tabs
  material_tabs(
    tabs = c(
      "First Tab" = "first_tab",
      "Second Tab" = "second_tab"
    )
  ),
  # Define tab content
  material_tab_content(
    tab_id = "first_tab",
    tags$h1("First Tab Content")
  ),
  material_tab_content(
    tab_id = "second_tab",
    tags$h1("Second Tab Content")
  )
)

server <- function(input, output) {
  
}
shinyApp(ui = ui, server = server)


ui <- material_page(
  title = "Basic Page + Parallax",
  # Typically the image will be placed in a folder labeled 'www' 
  # at the same level as the application (server.R & ui.R)
  material_parallax(
    image_source =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Freudenberg_sg_Switzerland.jpg/1920px-Freudenberg_sg_Switzerland.jpg"
  ),
  tags$h1("Page Content")
)
shinyApp(ui, server)
