selectedDisplayUi <- function(id){
  ns <- shiny::NS(id)
  shiny::tagList(
    DT::dataTableOutput(ns("select_data_display"))
  )
  
}

selectedDisplayServer <- function(id, r){
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    output$select_data_display <- DT::renderDataTable({
      datatable_display(r$selected_data)
    })
    
  })
}