sidebarUi <- function(id){
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fileInput(ns("file_upload"), label = "Influencers to choose from", multiple = FALSE),
    shiny::div( # I might want to make an orange halo for focus mode
      class = "file-input-warning",
      shiny::fileInput(
        ns("exclusions"), 
        label = shiny::HTML('<i class="fa fa-exclamation-triangle" <span style="color: #FFA500;"></i><span style="color: #FFA500;">Influencers to exclude</span>'),
        multiple = TRUE
        )
    ),
    shiny::conditionalPanel(
      "output.exclusions_uploaded", ns = ns,
      select_input_with_tooltip(
        ns("antijoin_on"), "Exclude based on:", 
        "Exclude users from the seeding based on presence in which column of the uploaded 'exclude dataframe? Note that 'id' and 'email' are the only truly unique columns so if you remove users based on their presence in any other column, e.g. 'nickname', you may remove users erroneously.", 
        choice_list = list(), select = NULL, multiple_selections = FALSE),
    ),
    shiny::uiOutput(ns("status_props")),
    shiny::numericInput(ns("n_choose"), value = 100, label = "How many influeners do you want to select?", updateOn = "blur"), # currently updates when enter button hit but maybe should be go button? 
    select_input_with_tooltip(ns("priority_col1"), "Priority 1:", "Variable to sort values on. Do you want to select the top users by number of test? number of points?", choice_list = list(), select = NULL, multiple_selections = F), # could just use one with multiple selections?
    select_input_with_tooltip(ns("priority_col2"), "Priority 2:", "A secondary variable to sort values on. This will be used to prioritise users where there is a tie between users in the first priority variable.", choice_list = list(), select = NULL, multiple_selections = F),
    shiny::actionButton(ns("select_action"), "Complete Seeding", icon = shiny::icon("seedling"))
  )
  
}

sidebarServer <- function(id, r){
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    shiny::observe({
      shiny::updateSelectizeInput(session = session, "priority_col1", choices = colnames(r$df), selected = "none")
      shiny::updateSelectizeInput(session = session, "priority_col2", choices = colnames(r$df), selected = "none")
      shiny::updateSelectizeInput(session = session, "antijoin_on", choices = colnames(r$df), selected = "none")
      shiny::updateNumericInput(session = session, "n_choose", max = nrow(r$df))
    })
    
    output$exclusions_uploaded <- shiny::reactive({
      !is.null(input$exclusions)
    })
    outputOptions(output, "exclusions_uploaded", suspendWhenHidden = FALSE)
    
    output$status_props <- shiny::renderUI({
      ns <- shiny::NS(id)
      req(r$input_status_props)
      shiny::tagList(
        shiny::div(
          style = "display: flex; align-items: flex-end; gap: 15px;",
          lapply(names(r$input_status_props), function(x)
              shiny::numericInput(ns(x), label = x, value = r$input_status_props[[x]], max = 1)

          )
        )
      )
    })
    
    shiny::observeEvent(input$file_upload, {
      r$df <- load_data(input$file_upload$datapath)
      
      })
    
    shiny::observeEvent(input$exclusions, {
      r$exclude_df <- load_data(input$exclusions$datapath)
    })
    
    shiny::observeEvent(input$select_action, {
      r$selected_data <- select_data(
        df = r$df,
        n_select = input$n_choose,
        sort_by = c(input$priority_col1, input$priority_col2), # is this the best way to pass?
        exclude = r$exclude_df,
        exclude_on = input$antijoin_on,
        prop_vec = c(input$Star, input$`Shooting Star`, input$`Rising Star`, input$Supernova)
      ) # add other metrics
    })
    
  })
}