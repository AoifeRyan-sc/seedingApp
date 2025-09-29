sidebarUi <- function(id){
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fileInput(ns("file_upload"), label = "Influencers to choose from", multiple = FALSE),
    shiny::fileInput(ns("exclusions"), label = "Influencers to exclude", multiple = TRUE),
    shiny::numericInput(ns("n_choose"), value = 100, label = "How many influeners do you want to select?", updateOn = "blur"), # currently updates when enter button hit but maybe should be go button? 
    select_input_with_tooltip(ns("select_cols"), "Choose by:", "i literally have no idea what this is going to be for", choice_list = list(), select = NULL, multiple_selections = TRUE),
    shiny::actionButton(ns("select_action"), "Complete Seeding", icon = shiny::icon("seedling"))
  )
  
}

sidebarServer <- function(id, r){
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    shiny::observe({
      shiny::updateSelectizeInput(session = session, "select_cols", choices = colnames(r$df), selected = "none")
      shiny::updateNumericInput(session = session, "n_choose", max = nrow(r$df))
    })
    
    shiny::observeEvent(input$file_upload, {
      r$df <- load_data(input$file_upload$datapath)
      
      })
    
    shiny::observeEvent(input$exclusions, {
      r$exclude_df <- load_data(input$file_upload$exclusions)
    })
    
    shiny::observeEvent(input$select_action, {
      print(head(r$df))
      print(length(r$df))
      print(input$n_choose)
      
      r$selected_data <- select_data(
        df = r$df,
        n_select = input$n_choose,
        sort_by = input$select_cols,
        exclude = ifelse(r$exclude, r$exclude, NULL)
      ) # add other metrics
    })
    
  })
}