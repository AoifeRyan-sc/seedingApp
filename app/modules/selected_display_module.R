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
      DT::datatable(r$selected_data, filter = "top", options = list(select = list(maxOptions = 2000), dom = 'Bfrtip', buttons = c("copy", "csv", "excel", "pdf"), pageLength = 10))
    })
    
  })
}