# df <- read.csv("~/Downloads/TokyWoky-Export-Participants-Test-2658 (8-20-2025).csv")
# exclude <- readxl::read_xlsx("../sample_data/Maybelline Wondersnatch 15.09.25.xlsx")

ui <- bslib::page_sidebar(
  sidebar = bslib::sidebar(
    sidebarUi("sidebar_panel")
  ),

  bslib::navset_card_underline(
    bslib::nav_panel(
      "Full List",
      inputDisplayUi("input_display_panel")
      ),
    bslib::nav_panel("Selected", plotOutput("bill_depth")),
    bslib::nav_panel("Stats", plotOutput("body_mass"))
  )
)
# 
# ui <- fluidPage(
#   # Set the title of the app
#   shiny::titlePanel("Interactive Dashboard Layout"),
#   
#   # Create the two-column layout
#   shiny::sidebarLayout(
#     # Sidebar with input controls
#     shiny::sidebarPanel(
#       shiny::h3("Controls"),
#       
#       # Placeholder for a dropdown menu or select input
#       shiny::selectInput("select_var", "Select a Variable:",
#                   choices = c("A", "B", "C")),
#       
#       # Placeholder for a slider input
#       shiny::sliderInput("slider_range", "Select a Range:",
#                   min = 0, max = 100, value = c(20, 80)),
#       
#       # Placeholder for checkboxes
#       shiny::checkboxGroupInput("checkbox_group", "Select Options:",
#                          choices = c("Option 1", "Option 2", "Option 3")),
#       
#       # Placeholder for more inputs
#       shiny::actionButton("go", "Run Analysis")
#     ),
#     
#     # Main panel with plots and outputs
#     shiny::mainPanel(
#       shiny::h3("Plots and Visualizations"),
#       
#       # First row for smaller plots
#       shiny::fluidRow(
#         shiny::column(6,
#                # Placeholder for the first plot (e.g., a histogram or density plot)
#                shiny::plotOutput("plot1")
#         ),
#         shiny::column(6,
#                # Placeholder for the second plot (e.g., a bar chart or donut chart)
#                shiny::plotOutput("plot2")
#         )
#       ),
#       
#       # Second row for the larger plots
#       shiny::fluidRow(
#         shiny::column(6,
#                # Placeholder for the third plot (e.g., a circular plot)
#                shiny::plotOutput("plot3")
#         ),
#         shiny::column(6,
#                # Placeholder for the fourth plot (e.g., a stacked bar chart)
#                shiny::plotOutput("plot4")
#         )
#       ),
#       
#       # Third row for the wide plot
#       shiny::fluidRow(
#         shiny::column(12,
#                # Placeholder for the fifth, wide plot (e.g., a line plot or wave visualization)
#                shiny::plotOutput("plot5")
#         )
#       )
#     )
#   )
# )
