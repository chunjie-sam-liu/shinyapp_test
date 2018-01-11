library(shiny)
library(shinyWidgets)
shinyApp(
   ui = fluidPage(
     useSweetAlert(),
     actionButton(inputId = "success", label = "Success", class = "btn-success"),
     actionButton(inputId = "error", label = "Error", class = "btn-danger"),
     actionButton(inputId = "info", label = "Info", class = "btn-info"),
     actionButton(inputId = "warning", label = "Warning", class = "btn-warning"),
     actionButton(inputId = "tags", label = "With HTML")
   ),
   server = function(input, output, session){
     observeEvent(input$success, {
       sendSweetAlert(
         session = session,
         title = "Success !!",
         text = "All in order",
         type = "success"
       )
     })
     
     observeEvent(input$error, {
       sendSweetAlert(
         session = session,
         title = "Error...",
         text = "Oups !",
         type = "error"
       )
     })
    
     observeEvent(input$info, {
       sendSweetAlert(
         session = session,
         title = "Information",
         text = "Something helpful",
         type = "info"
       )
     })
     
     observeEvent(input$tags, {
       sendSweetAlert(
         session = session,
         title = "HTLM tags",
         text = "normal <b>bold</b> <span style='color: steelblue;'>color</span> <h1>h1</h1>",
         html = TRUE,
         type = NULL
       )
     })
     
     observeEvent(input$warning, {
       sendSweetAlert(
         session = session,
         title = "Warning !!!",
         text = NULL,
         type = "warning"
       )
     })
     
   }
   )
