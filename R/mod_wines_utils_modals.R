#' Get Unique and Sorted Values from a Column
#'
#' This function extracts unique values from a specified column in the `wines` data frame,
#' counts their occurrences, and returns them sorted in descending order of frequency.
#'
#' @param wines A data frame containing the wine collection data.
#' @param column_name The name of the column from which to extract unique values.
#' The column name should be passed unquoted.
#'
#' @return A character vector of unique values from the specified column,
#' sorted by frequency in descending order.
#'
#' @examples
#' wines <- data.frame(
#'   country = c("Germany", "France", "Italy", "Germany"),
#'   variety = c("Riesling", "Cabernet", "Sangiovese", "Riesling")
#' )
#' get_choices(wines, country)
#' @noRd
get_choices <- function(wines, column_name) {
  wines |>
    dplyr::count({{ column_name }}) |>
    dplyr::arrange(dplyr::desc(n)) |>
    dplyr::pull({{ column_name }})
}

#' Create a Modal Dialog for Adding a New Wine Entry
#'
#' This function generates a modal dialog in a Shiny application that allows the user
#' to input details for adding a new wine to the collection.
#'
#' @param ns A namespace function for the Shiny module. This ensures that the IDs used
#' in the modal are unique.
#' @param wines A data frame containing the existing wine collection data.
#' @param shelf_slot_cap The maximum number of bottles that can be stored in a shelf slot.
#'
#' @return A `modalDialog` object that can be displayed in a Shiny application.
#'
#' @noRd
add_wine_modal <- function(ns, wines, shelf_slot_cap) {
  modalDialog(
    title = "Neuen Wein eintragen",
    numericInput(
      ns("vintage"), "Jahrgang",
      value = 2010,
      min = 1900, max = Sys.Date() |> format("%Y") |> as.numeric(), step = 1
    ),
    selectizeInput(
      ns("variety"), "Rebsorte(n):",
      choices = wines |> get_choices(variety),
      selected = NULL,
      multiple = TRUE,
      options = list(create = TRUE, placeholder = "Rebsorte(n) auswählen...")
    ),
    textInput(
      ns("name"), "Name:", placeholder = "Name eingeben..."
    ),
    selectizeInput(
      ns("winery"), "Weingut:",
      choices = wines |> get_choices(winery),
      options = list(create = TRUE, placeholder = "Weingut auswählen...")
    ),
    selectizeInput(
      ns("region"), "Anbaugebiet:",
      choices = wines |> get_choices(region),
      options = list(create = TRUE, placeholder = "Anbaugebiet auswählen...")
    ),
    selectizeInput(
      ns("country"), "Land:",
      choices = wines |> get_choices(country),
      options = list(create = TRUE, placeholder = "Land auswählen...")
    ),
    numericInput(
      ns("bottle_count"), "Anzahl:", value = 1,
      min = 1, max = shelf_slot_cap, step = 1
    ),
    textInput(
      ns("shelf_slot"), "Regalfach:", placeholder = "Regalfach eingeben..."
    ),
    footer = tagList(
      modalButton("Abbrechen"),
      shinyjs::disabled(bs4Dash::actionButton(ns("btn_add_confirm"), "Bestätigen", status = "primary"))
    ),
    size = "s",
    easyClose = TRUE
  )
}

#' Create a Modal Dialog for Removing Wine
#'
#' This function generates a modal dialog in a Shiny application that allows the user
#' to remove a specified amount of wine from the collection.
#'
#' @param ns A namespace function for the Shiny module. This ensures that the IDs used
#' in the modal are unique.
#' @param wine A data frame containing the details of the wine to be removed.
#' @param cols A character vector specifying the columns of the `wine` data frame to display
#' in the modal for confirmation.
#'
#' @return A `modalDialog` object that can be displayed in a Shiny application.
#'
#' @noRd
remove_wine_modal <- function(ns, wine, cols) {
  modalDialog(
    title = "Wein entnehmen",
    renderTable(
      data.frame(
        key = wine |> dplyr::select(dplyr::all_of(cols)) |> names(),
        val = wine |> dplyr::select(dplyr::all_of(cols)) |> as.character() |> as.vector()
      ),
      colnames = FALSE
    ),
    numericInput(
      ns("remove_amount"), "Entnahmemenge:",
      value = 1, min = 1, max = wine |> dplyr::pull(amount), step = 1
    ),
    footer = tagList(
      modalButton("Abbrechen"),
      bs4Dash::actionButton(ns("btn_remove_confirm"), "Bestätigen", status = "primary")
    ),
    size = "s",
    easyClose = TRUE
  )
}
