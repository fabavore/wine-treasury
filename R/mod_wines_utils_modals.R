add_wine_modal <- function(ns, wines, shelf_cap) {
  modalDialog(
    title = "Neuen Wein eintragen",
    numericInput(
      ns("vintage"), "Jahrgang",
      value = 2010,
      min = 1900, max = Sys.Date() |> format("%Y") |> as.numeric(), step = 1
    ),
    selectizeInput(
      ns("variety"), "Rebsorte(n):",
      choices = wines()$variety |> unique(),
      selected = NULL,
      multiple = TRUE,
      options = list(create = TRUE, placeholder = "Rebsorte(n) auswählen...")
    ),
    textInput(
      ns("name"), "Name:", placeholder = "Name eingeben..."
    ),
    selectizeInput(
      ns("winery"), "Weingut:",
      choices = wines()$winery |> unique(),
      selected = NULL,
      options = list(create = TRUE, placeholder = "Weingut auswählen...")
    ),
    selectizeInput(
      ns("region"), "Anbaugebiet:",
      choices = wines()$region |> unique(),
      selected = NULL,
      options = list(create = TRUE, placeholder = "Anbaugebiet auswählen...")
    ),
    selectizeInput(
      ns("country"), "Land:",
      choices = wines()$country |> unique(),
      selected = NULL,
      options = list(create = TRUE, placeholder = "Land auswählen...")
    ),
    numericInput(
      ns("amount"), "Menge:", value = 1,
      min = 1, max = shelf_cap(), step = 1
    ),
    textInput(
      ns("shelf"), "Regalnummer:", placeholder = "Regalnummer eingeben..."
    ),
    footer = tagList(
      modalButton("Abbrechen"),
      bs4Dash::actionButton(ns("btn_add_confirm"), "Bestätigen", status = "primary")
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
        key = wine() |> dplyr::select(dplyr::all_of(cols)) |> names(),
        val = wine() |> dplyr::select(dplyr::all_of(cols)) |> as.character() |> as.vector()
      ),
      colnames = FALSE
    ),
    numericInput(
      ns("remove_count"), "Entnahmemenge:",
      value = 1, min = 1, max = 6, step = 1
    ),
    footer = tagList(
      modalButton("Abbrechen"),
      bs4Dash::actionButton(ns("btn_remove_confirm"), "Bestätigen", status = "primary")
    ),
    size = "s",
    easyClose = TRUE
  )
}
