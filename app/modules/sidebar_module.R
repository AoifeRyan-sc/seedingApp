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
    # shiny::h4("Proportion of statuses in seeding:"),
    # shiny::numericInput(ns("star"), label = "Star", value = 0, max = 1),
    # shiny::fluidRow(
    #   shiny::column(3, div("Star:", style = "margin-top: 7px; font-weight: bold;")),
    #   shiny::column(9, shiny::numericInput(ns("star"), label = NULL, value = 0, max = 1))
    # ),
    # inlinNumericInput(id = ns("star"), label = "Star", value = 0, max = 1),
    # inlinNumericInput(id = ns("star"), label = "Star", value = 0, max = 1),
    shiny::uiOutput(ns("status_props")),
    shiny::numericInput(ns("n_choose"), value = 100, label = "How many influeners do you want to select?", updateOn = "blur"), # currently updates when enter button hit but maybe should be go button? 
    select_input_with_tooltip(ns("select_cols"), "Choose by:", "Variable to sort values on. Do you want to select the top users by number of test? number of points?", choice_list = list(), select = NULL, multiple_selections = TRUE),
    shiny::actionButton(ns("select_action"), "Complete Seeding", icon = shiny::icon("seedling"))
  )
  
}

sidebarServer <- function(id, r){
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    shiny::observe({
      shiny::updateSelectizeInput(session = session, "select_cols", choices = colnames(r$df), selected = "none")
      shiny::updateSelectizeInput(session = session, "antijoin_on", choices = colnames(r$df), selected = "none")
      shiny::updateNumericInput(session = session, "n_choose", max = nrow(r$df))
      # shiny::updateNumericInput(session = session, "star", value = r$input_status_props[["Star"]], max = 1)
    })
    
    output$exclusions_uploaded <- shiny::reactive({
      !is.null(input$exclusions)
    })
    outputOptions(output, "exclusions_uploaded", suspendWhenHidden = FALSE)
    
    output$status_props <- shiny::renderUI({
      ns <- shiny::NS(id)
      req(r$input_status_props)
      shiny::tagList(
        lapply(names(r$input_status_props), function(x)
             inlineNumericInput(id = ns(x), label = x, value = r$input_status_props[[x]], max = 1))
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
        sort_by = input$select_cols,
        # exclude = ifelse(r$exclude_df, r$exclude_df, NULL),
        exclude = r$exclude_df,
        exclude_on = input$antijoin_on
      ) # add other metrics
    })
    
  })
}