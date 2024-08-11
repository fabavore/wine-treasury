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
      choices = wines$variety |> unique(),
      selected = NULL,
      multiple = TRUE,
      options = list(create = TRUE, placeholder = "Rebsorte(n) auswählen...")
    ),
    textInput(
      ns("name"), "Name:", placeholder = "Name eingeben..."
    ),
    selectizeInput(
      ns("winery"), "Weingut:",
      choices = wines$winery |> unique(),
      selected = NULL,
      options = list(create = TRUE, placeholder = "Weingut auswählen...")
    ),
    selectizeInput(
      ns("region"), "Anbaugebiet:",
      choices = wines$region |> unique(),
      selected = NULL,
      options = list(create = TRUE, placeholder = "Anbaugebiet auswählen...")
    ),
    selectizeInput(
      ns("country"), "Land:",
      choices = wines$country |> unique(),
      selected = NULL,
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
