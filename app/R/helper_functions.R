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

select_data <- function(df, n_select, sort_by, exclude = NULL, exclude_on = NULL){
  print(head(exclude))
  
  selected <- df
  
  if (!is.null(exclude)){
    print("antijoining")
    selected <- selected %>%
      dplyr::anti_join(exclude, by = exclude_on)
  }
  
  return(selected)
  
}

find_uk <- function(df, country_col1, country_col2 = NULL){
  
  # need to add checks for cols
  uk_df <- df %>%
    dplyr::mutate(country = stringr::str_trim(country),
                  country = tolower(country),
                  city = stringr::str_trim(city),
                  city = tolower(city)) %>%
    dplyr::filter(country_2 == "UK",
                  !country %in% ni_towns,
                  !city %in% ni_towns,
                  !grepl("ireland|isle of man", country))
  
  return(uk_df)
  
}

make_barchart <- function(df){
  
  print("2happeneingwdva
        sg")
  # how to deal with status_columns???
  status_col <- names(df)[grepl("status", names(df))]
  status_ensym <- rlang::ensym(status_col)
  stopifnot(length(status_col) == 1)
  
  grouped_data <- df %>%
    dplyr::count(!!status_ensym) %>%
    dplyr::mutate(prop = n/sum(n))

  p <- grouped_data %>%
    ggplot2::ggplot(ggplot2::aes(x = !!status_ensym, y = prop, fill = !!status_ensym)) +
    ggplot2::geom_col() +
    ggplot2::labs(x = NULL, y = "Proportion of input dataset") +
    ggplot2::geom_text(ggplot2::aes(label = n), vjust = -0.5) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      panel.grid = ggplot2::element_blank(),
      legend.position = "None"
      )

  print("done")  
  prop_info <- round(grouped_data$prop, 2)
  names(prop_info) <- grouped_data$status # name status might change
  
  print(prop_info)
  
  return(list(plot = p, status_info = prop_info))
}

