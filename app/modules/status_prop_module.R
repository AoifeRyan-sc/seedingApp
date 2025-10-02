statusInputDisplayUi <- function(id){
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::plotOutput(ns("status_proportion_display"))
  )
  
}

statusInputDisplayServer <- function(id, r){
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$status_proportion_display <- shiny::renderPlot({
      req(r$df)
      result <- make_barchart(r$df)
      r$input_status_props <- result$status_info

      result$p
    })
    
  })
}