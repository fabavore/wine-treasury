#' dashboard UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_dashboard_ui <- function(id){
  ns <- NS(id)
  tagList(
    bs4Dash::dashboardPage(
      header = bs4Dash::dashboardHeader(
        title = "Schatzkammer"
      ),
      sidebar = bs4Dash::dashboardSidebar(
        bs4Dash::sidebarMenu(
          bs4Dash::menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
          bs4Dash::menuItem("Weine", tabName = "wines", icon = icon("wine-bottle"), selected = T)
        )
      ),
      body = bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(
            tabName = "dashboard"
          ),
          bs4Dash::tabItem(
            tabName = "wines",
            mod_wines_ui(ns("wines_1"))
          )
        )
      )
    )
  )
}

#' dashboard Server Functions
#'
#' @noRd
mod_dashboard_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    wines <- reactiveVal(
      data.frame(
        rowid = c(1, 2, 3, 4, 5),
        shelf = c("101", "202", "303", "404", "505"),
        amount = c(1, 3, 1, 2, 1),
        vintage = c(2015, 2018, 2019, 2016, 2020),
        variety = c("Riesling", "Cabernet Sauvignon", "Spätburgunder", "Sangiovese", "Malbec"),
        name = c("Müller Thurgau", "Margaux", "Schmidt Pinot Noir", "Sassicaia", "Catena Alta"),
        winery = c("Weingut Müller", "Château Margaux", "Weingut Schmidt", "Tenuta San Guido", "Bodega Catena Zapata"),
        region = c("Mosel", "Bordeaux", "Pfalz", "Toskana", "Mendoza"),
        country = c("Deutschland", "Frankreich", "Deutschland", "Italien", "Argentinien")
      )
    )

    shelf_cap <- reactiveVal(6)

    mod_wines_server("wines_1", wines, shelf_cap)
  })
}

## To be copied in the UI
# mod_dashboard_ui("dashboard_1")

## To be copied in the server
# mod_dashboard_server("dashboard_1")
