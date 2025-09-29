library(shiny)
library(here)
library(magrittr)

options(shiny.autoreload.legacy_warning = FALSE)
options(shiny.autoreload=TRUE)
options(shiny.port = 7775)
options(shiny.host = "127.0.0.1")

source(here("app/R/ui_helper_functions.R"))
source(here("app/R/helper_functions.R"))

source(here("app/modules/sidebar_module.R"))
source(here("app/modules/input_display_module.R"))
source(here("app/modules/selected_display_module.R"))

source(here("app/ui.R"))
source(here("app/server.R"))

if(interactive()){
  shinyApp(ui, server)
} else {
  shiny::runApp(here::here("app"))
}


