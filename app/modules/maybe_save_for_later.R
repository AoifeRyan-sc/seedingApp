

#### Beginings of a modal pop up for chosig names of "important cols - sidebar_module
important_cols <- c("id", "test_status", "country") # maybe I need to rethink how country is done
missing_cols <- setdiff(important_cols, names(r$df))

if (length(missing_cols) != 0){
  n_missing <- length(missing_cols)
  shiny::showModal(
    shiny::modalDialog(
      shiny::h3(
        paste0(
          "Potentially important columns are missing from your dataframe: \n",
          paste(missing_cols, collapse = ", "), ".\n",
          "Press `Continue` now if you do not need these columns. Otherwise select the correct columns before continuing"
        )
      ),
      lapply(missing_cols, function(item) {
        select_input_with_tooltip(
          ns("select_cols"), 
          title = paste0(item, ":"),
          paste0("Select the column in the df corresponding to ", item), 
          choice_list = names(r$df), 
          select = NULL, 
          multiple_selections = FALSE
        )
      })
    )
  )
}