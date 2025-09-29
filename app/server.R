server <- function(input, output, session) {
  
  r <- shiny::reactiveValues(
    # df = df,
    # exclude_df = exclude # what happens if they upload multiple?
  )
  exclude <- readxl::read_xlsx("../sample_data/Maybelline Wondersnatch 15.09.25.xlsx")
  sidebarServer("sidebar_panel", r)
  inputDisplayServer("input_display_panel", r)
  
  
  
  
}