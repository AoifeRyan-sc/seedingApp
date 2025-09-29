ui <- bslib::page_sidebar(
  sidebar = bslib::sidebar(
    sidebarUi("sidebar_panel")
  ),

  bslib::navset_card_underline(
    bslib::nav_panel(
      "Full List",
      inputDisplayUi("input_display_panel") # maybe only want to display certain cols for readability?
      ),
    bslib::nav_panel("Selected", 
                     selectedDisplayUi("select_display_panel")
                     ),
    bslib::nav_panel("Stats", plotOutput("body_mass"))
  )
)
