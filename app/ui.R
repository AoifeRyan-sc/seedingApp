ui <- bslib::page_sidebar(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  sidebar = bslib::sidebar(
    sidebarUi("sidebar_panel"),
    width = 500,
    resizable = T
  ),

  # bslib::navset_underline(
  # bslib::page_navbar(
  bslib::navset_tab(
    bslib::nav_panel(
      "Data Overview", 
      bslib::layout_column_wrap(
        style = "margin-top: 20px;", 
        bslib::card(
          bslib::card_header("Uploaded Data"),
          bslib::card_body(inputDisplayUi("input_display_panel")), # maybe only want to display certain cols for readability?
          full_screen = T
        ),
        width = 1,
        fill = F,
        bslib::layout_column_wrap(
          width = 1/2,
          height_equal = "row",
          bslib::card(
            bslib::card_header("Status distribution in input data"),
            bslib::card_body(statusInputDisplayUi("status_input_display_panel")),
            full_screen = T
          ),
          bslib::card(
            bslib::card_header("Another Plot for something"),
            bslib::card_body(shiny::plotOutput("plot2")),
            full_screen = T
          )
        )
      )
      ),
    # bslib::nav_panel(
    #   "Full List",
    #   ),
    bslib::nav_panel(
      "Selected", 
      selectedDisplayUi("select_display_panel")
      )
  )
)
