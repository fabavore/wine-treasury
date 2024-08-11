#' wines UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom DT DTOutput renderDT
mod_wines_ui <- function(id){
  ns <- NS(id)
  tagList(
    shinyjs::useShinyjs(),
    fluidRow(
      bs4Dash::box(
        title = "Weinsammlung",
        status = "primary",
        solidHeader = TRUE,
        width = 12,
        collapsible = FALSE,
        shinyjs::hidden(selectizeInput(ns("dummy"), "", choices = NULL)),
        actionButton(ns("btn_add"), "Neuen Wein eintragen", icon = icon("plus")),
        shinyjs::disabled(actionButton(ns("btn_remove"), "Wein entnehmen", icon = icon("wine-glass"))),
        br(), br(),
        DTOutput(ns("dt_wines"))
      )
    )
  )
}

#' wines Server Functions
#'
#' @noRd
mod_wines_server <- function(id, wines, shelf_cap){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$dt_wines <- renderDT({
      wines()
    },
    options = list(
      language = list(
        url = "//cdn.datatables.net/plug-ins/1.10.21/i18n/German.json"
      )
    ),
    rownames = FALSE,
    selection = "single",
    filter = "top")

    wine_selected <- reactive({
      wines() |> dplyr::slice(input$dt_wines_rows_selected[[1]])
    })

    observe({
      shinyjs::toggleState("btn_remove", not_null(input$dt_wines_rows_selected))
    })

    observe({
      showModal(add_wine_modal(ns, wines, shelf_cap))
    }) |> bindEvent(input$btn_add)

    observe({
      removeModal()
    }) |> bindEvent(input$btn_add_confirm)

    observe({
      showModal(remove_wine_modal(ns))
    }) |> bindEvent(input$btn_remove)

    observe({
      removeModal()
    }) |> bindEvent(input$btn_remove_confirm)
  })
}

## To be copied in the UI
# mod_wines_ui("wines_1")

## To be copied in the server
# mod_wines_server("wines_1")
