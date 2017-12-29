
library(shiny)
csvFileInput <- function(id, label = "CSV file") {
  # Create a namespace function using the provided id
  ns <- NS(id)
  
  tagList(
    fileInput(ns("file"), label),
    checkboxInput(ns("heading"), "Has heading"),
    selectInput(ns("quote"), "Quote", c(
      "None" = "",
      "Double quote" = "\"",
      "Single quote" = "'"
    ))
  )
}


csvFile <- function(input, output, session, stringsAsFactors) {
  # The selected file, if any
  userFile <- reactive({
    # If no file is selected, don't do anything
    validate(need(input$file, message = FALSE))
    input$file
  })
  
  # The user's data, parsed into a data frame
  dataframe <- reactive({
    read.csv(userFile()$datapath,
             header = input$heading,
             quote = input$quote,
             stringsAsFactors = stringsAsFactors)
  })
  
  # We can run observers in here if we want to
  observe({
    msg <- sprintf("File %s was uploaded", userFile()$name)
    cat(msg, "\n")
  })
  
  # Return the reactive that yields the data frame
  return(dataframe)
}


library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(csvFileInput("datafile", "User data (.csv format)")),
    mainPanel(dataTableOutput("table"))
  )
)

server <- function(input, output, session) {
  datafile <- callModule(csvFile, "datafile", stringsAsFactors = FALSE)
  
  output$table <- renderDataTable({datafile()})
}




Kidney_choice <- list(
  "Kidney Chromophobe(KICH)" = "KICH",
  "Kidney Renal Clear Cell Carcinoma(KIRC)" = "KIRC",
  "Kidney Renal Papillary Cell Carcinoma(KIRP)" = "KIRP"
)
Adrenal_Gland_choice <- list(
  "Adrenocortical Carcinoma(ACC)" = "ACC",
  "Pheochromocytoma and Paraganglioma(PCPG)" = "PCPG"
)
Brain_choice <- list(
  "Glioblastoma Multiforme(GBM)" = "GBM",
  "Brain Lower Grade Glioma(LGG)" = "LGG"
)
Colorectal_choice <- list(
  "Colon Adenocarcinoma(COAD)" = "COAD",
  "Rectum Adenocarcinoma(READ)" = "READ"
)
Lung_choice <- list(
  "Lung Adenocarcinoma(LUAD)" = "LUAD",
  "Lung Squamous Cell Carcinoma(LUSC)" = "LUSC"
)
Uterus_choice <- list(
  "Uterine Corpus Endometrial Carcinoma(UCEC)" = "UCEC",
  "Uterine Carcinosarcoma(UCS)" = "UCS"
)
Bile_Duct_choice <- list("Bladder Urothelial Carcinoma(BLCA)" = "BLCA")
Bone_Marrow_choice <- list("Acute Myeloid Leukemia(LAML)" = "LAML")
Breast_choice <- list("Breast Invasive Carcinoma(BRCA)" = "BRCA")
Cervix_choice <- list("Cervical Squamous Cell Carcinoma and Endocervical Adenocarcinoma(CESC)" = "CESC")
other_tissue_choice <- list(
  "Lymphoid Neoplasm Diffuse Large B-cell Lymphoma(DLBC)" = "DLBC",
  "Esophageal Carcinoma(ESCA)" = "ESCA",
  "Stomach Adenocarcinoma(STAD)" = "STAD",
  "Head and Neck Squamous Cell Carcinoma(HNSC)" = "HNSC",
  "Liver Hepatocellular Carcinoma(LIHC)" = "LIHC",
  "Mesothelioma(MESO)" = "MESO",
  "Ovarian Serous Cystadenocarcinoma(OV)" = "OV",
  "Pancreatic Adenocarcinoma(PAAD)" = "PAAD",
  "Prostate Adenocarcinoma(PRAD)" = "PRAD",
  "Sarcoma(SARC)" = "SARC",
  "Skin Cutaneous Melanoma(SKCM)" = "SKCM",
  "Testicular Germ Cell Tumors(TGCT)" = "TGCT",
  "Thyroid Carcinoma(THCA)" = "THCA",
  "Thymoma(THYM)" = "THYM",
  "Uveal Melanoma(UVM)" = "UVM"
)

# cancer type selection ---------------------------------------------------
cancerTypeInput <- function(id) {
  ns <- NS(id)
  
  tagList(
    fluidRow(
      # cancer type selection----
      column(
        width = 10,
        offset = 1,
        shiny::tags$br(),
        shiny::tags$h3("Cancer Type Selection", class = "text-success"),
        shiny::tags$br(),
        
        shinydashboard::tabBox(
          width = 12, title = "Tissue",
          tabPanel(
            "Kidney",
            shiny::tags$h4("Kidney", class = "text-success"),
            checkboxGroupButtons(
              inputId = ns("Kidney"), label = NULL,
              choices = Kidney_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Adrenal Gland",
            checkboxGroupButtons(
              inputId = ns("Adrenal_Gland"), label = NULL,
              choices = Adrenal_Gland_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Brain",
            checkboxGroupButtons(
              inputId = ns("Brain"), label = NULL,
              choices = Brain_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Colorectal",
            checkboxGroupButtons(
              inputId = ns("Colorectal"), label = NULL,
              choices = Colorectal_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Lung",
            checkboxGroupButtons(
              inputId = ns("Lung"), label = NULL,
              choices = Lung_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Uterus",
            checkboxGroupButtons(
              inputId = ns("Uterus"), label = NULL,
              choices = Uterus_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Bile Duct",
            checkboxGroupButtons(
              inputId = ns("Bile_Duct"), label = NULL,
              choices = Bile_Duct_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Bone Marrow",
            checkboxGroupButtons(
              inputId = ns("Bone_Marrow"), label = NULL,
              choices = Bone_Marrow_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Breast",
            checkboxGroupButtons(
              inputId = ns("Breast"), label = NULL,
              choices = Breast_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Cervix",
            checkboxGroupButtons(
              inputId = ns("Cervix"), label = NULL,
              choices = Cervix_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          ),
          tabPanel(
            "Other tissues",
            checkboxGroupButtons(
              inputId = ns("other_tissue"), label = NULL,
              choices = other_tissue_choice,
              justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
              direction = "vertical",
              individual = TRUE
            )
          )
        )
      ),
      shiny::tags$hr(width = "85%")
    )
  )
}


selectAndAnalysisInput <- function(id) {
  ns <- NS(id)
  shiny::tagList(
    column(
      width = 2, offset = 4,
      switchInput(
        inputId = ns("switch"), value = TRUE,
        onLabel = "Select All",
        offLabel = "Deselect All"
      )
    ),
    column(
      width = 2, offset = 1,
      shiny::tags$div(
        style = "margin:3px;", class = "form-group shiny-input-container",
        shinyBS::bsButton(inputId = ns("submit"), label = "Analysis", icon = icon(name = "fire"))
      )
    ),
    column(width = 4)
  )
}



library(shinyWidgets)
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(csvFileInput("datafile", "User data (.csv format)")),
    selectAndAnalysisInput('expr')
    # mainPanel(dataTableOutput("table"))
  ),
  mainPanel(cancerTypeInput("expr"))
)

sub_cancer_types <- list(
  Kidney = c( "KICH",  "KIRC",  "KIRP"),
  Adrenal_Gland = c( "ACC", "PCPG"),
  Brain = c("GBM", "LGG"),
  Colorectal = c( "COAD", "READ"),
  Lung  = c("LUAD", "LUSC"),
  Uterus = c("UCEC",  "UCS"),
  Bile_Duct = c("BLCA"),
  Bone_Marrow = c("LAML"),
  Breast = c("BRCA"),
  Cervix = c("CESC"),
  other_tissue = c("DLBC",  "ESCA", "STAD",  "HNSC",  "LIHC", "MESO",  "OV", "PAAD", "PRAD", "SARC", "SKCM", "TGCT", "THCA", "THYM", "UVM")
)

check_sub_cancer_types <- function(input, output, session, .cts, .check){
  names(.cts) %>% 
    purrr::walk(
      .f = function(.x) {
        .selected <- if (.check) .cts[[.x]] else character(0)
        updateCheckboxGroupButtons(
          session = session, 
          inputId = .x, selected = .selected, 
          checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
        )
      }
    )
}


selectAndAnalysis <- function(input, output, session, .id) {
  print(.id)
  observeEvent(
    eventExpr = input$switch,
    handlerExpr = {
      if (input$switch) {
        check_sub_cancer_types(input, output, session, sub_cancer_types, TRUE)
        print("select all")
        
      } else{
        check_sub_cancer_types(input, output, session, sub_cancer_types, FALSE)
        print("deselect all")
      }
      
    }
  )
}

server <- function(input, output, session) {
  callModule(module = selectAndAnalysis, id = "expr", .id = "expr")

}
shinyApp(ui = ui, server = server)


## Not run: 

  
  library(shiny)
  library(shinyWidgets)
  
  # Example 1 ----
  
  ui <- fluidPage(
    
    radioButtons(inputId = "up", label = "Update button :", choices = c("All", "None")),
    
    checkboxGroupButtons(
      inputId = "btn", label = "Power :",
      choices = c("Nuclear", "Hydro", "Solar", "Wind"),
      selected = "Hydro"
    ),
    
    verbatimTextOutput(outputId = "res")
    
  )
  
  server <- function(input,output, session){
    
    observeEvent(input$up, {
      if (input$up == "All"){
        updateCheckboxGroupButtons(session, "btn", selected = c("Nuclear", "Hydro", "Solar", "Wind"))
      } else {
        updateCheckboxGroupButtons(session, "btn", selected = character(0))
      }
    }, ignoreInit = TRUE)
    
    output$res <- renderPrint({
      input$btn
    })
  }
  
  shinyApp(ui = ui, server = server)
