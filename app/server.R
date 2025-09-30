server <- function(input, output, session) {
  
  r <- shiny::reactiveValues()
  exclude <- readxl::read_xlsx("../sample_data/Maybelline Wondersnatch 15.09.25.xlsx")
  sidebarServer("sidebar_panel", r)
  inputDisplayServer("input_display_panel", r)
  selectedDisplayServer("select_display_panel", r)
  statusInputDisplayServer("status_input_display_panel", r)
  
  
  
  
  
}