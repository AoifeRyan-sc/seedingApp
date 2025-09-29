load_data <- function(file_path){
  
  ext <- tools::file_ext(file_path)
  
  validate(need(ext %in% c("csv", "xlsx"), "Please upload a csv or xlsx")) 
  
  df <- switch(ext,
               csv = read.csv(file_path),
               xlsx = readxl::read_xlsx(file_path)) # maybe should use duckdb to read data in too
  
  df <- format_df(df)
  
  return(df)

}

format_dates <- function(df){
  
  output_df <- df
  
  if ("last_interaction" %in% names(df)){
    output_df <- output_df %>%
      dplyr::mutate(
        last_interaction = as.Date(last_interaction, format = "%d/%m/%Y"),
        days_since_last_interaction = as.numeric(Sys.Date() - last_interaction)
      )
  }
  
  if ("last_visited_date" %in% names(df)){
    output_df <- output_df %>%
      dplyr::mutate(
        last_visited_date = as.Date(last_visited_date, format = "%d/%m/%Y"),
        days_since_last_visit = as.numeric(Sys.Date() - last_visited_date)
      )
  }
  
  return(output_df)
  
}

format_df <- function(df){
  formatted_df <- df %>%
    janitor::clean_names()
  
  if (grepl("^user_", names(formatted_df)[1])){
    colnames(formatted_df) <-  sub("^user_", "", colnames(formatted_df))
  }
  
  formatted_df <- formatted_df %>% format_dates()
  
  return(formatted_df)
}

select_data <- function(df, n_select, sort_by, exclude = NULL){
  
  if (exclude){
    selected <- df %>%
      dplyr::anti_join(select, by = "id")
  }
  
}
