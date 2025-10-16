inputDisplayUi <- function(id){
  ns <- shiny::NS(id)
  shiny::tagList(
    DT::dataTableOutput(ns("input_data_display"))
  )
  
}

inputDisplayServer <- function(id, r){
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    output$input_data_display <- DT::renderDataTable({
      datatable_display(r$df)
    })
    
  })
}