library(shiny)
library(shinymaterial)

ui <- material_page(
  title = "Feature List",
  material_card(
    title = "Test card depth 1", depth = 1,
    material_button(input_id = "btn1", label = "Btn1", depth = 1),
    material_button(input_id = "btn5", label = "Btn5", depth = 5),
    material_dropdown(input_id = "dpd", label = "Dropdown", choices = c("Cake", "Pie", "Browne"), selected = "Cake", multiple = FALSE),
    material_slider(input_id = "slider", label = "Slider", min_value = 1, max_value = 100, initial_value = 50, color = "red"),
    material_switch(input_id = "switch", label = "Switch", off_label = "Off", on_label = "On"),
    material_password_box(input_id = "pswd", label = "Password", color = "red"),
    material_text_box(input_id = "txtb", label = "Text Box"),
    material_date_picker(input_id = "date", label = "Date picker"),
    material_file_input(input_id = "file", label = "File"),
    material_button(
      input_id = "example_button",
      label = "DEEP_ORANGE",
      color = "deep-orange"
    )
    
    ),
  material_card(
    title = "Test card depth 5", depth = 5,
    material_checkbox(input_id = "checkbox", label = "Checkbox"),
    material_radio_button(input_id = "radio_button", label = "Radio Button", choices = c("Cake", "Pie", "Browne")),
    material_number_box(input_id = "number_box", label = "Number Box", min_value = 0, max_value = 100, initial_value = 50),
    material_modal(
      modal_id = "example_modal",
      button_text = "Modal",
      button_icon = "open_in_browser",
      title = "Showcase Modal Title",
      tags$p("Modal Content")
    )
    )
  
)

shiny::shinyApp(ui, server = function(input, output, session){})


# Spinner -----------------------------------------------------------------

library(shiny)
library(shinymaterial)

ui <- material_page(
  title = "Spinner Example",
  numericInput(inputId = "n", label = "", value = 10),
  plotOutput("n_plot")
)

server <- function(input, output, session) {
  
  output$n_plot <- renderPlot({
    
    #--- Show the spinner ---#
    material_spinner_show(session, "n_plot")
    
    #--- Simulate calculation step ---#
    Sys.sleep(time = 2)
    
    #--- Hide the spinner ---#
    material_spinner_hide(session, "n_plot")
    
    plot(1:input$n)
  })
  
}
shinyApp(ui = ui, server = server)
