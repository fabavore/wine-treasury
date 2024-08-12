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
          bs4Dash::menuItem("Weine", tabName = "wines", icon = icon("wine-bottle"))
        )
      ),
      body = bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(
            tabName = "dashboard",
            fluidRow(
              bs4Dash::valueBox(
                value = textOutput(ns("total_amount")),
                subtitle = "Gesamtzahl der Flaschen",
                icon = icon("wine-bottle"),
                color = "primary"
              ),
              bs4Dash::valueBox(
                value = textOutput(ns("mean_age")),
                subtitle = "Durchschnittliches Alter",
                icon = icon("hourglass-half"),
                color = "primary"
              ),
              bs4Dash::valueBox(
                value = textOutput(ns("max_age")),
                subtitle = "Ältester Wein",
                icon = icon("hourglass-end"),
                color = "primary"
              ),
              bs4Dash::valueBox(
                value = textOutput(ns("most_frequent_region")),
                subtitle = "Häufigstes Anbaugebiet",
                icon = icon("map-marker-alt"),
                color = "primary"
              )
            ),
            fluidRow(
              bs4Dash::box(
                title = "Jahrgangsverteilung",
                status = "primary",
                solidHeader = TRUE,
                plotOutput(ns("plot_vintage"))
              ),
              bs4Dash::box(
                title = "Anbaugebiete",
                status = "primary",
                solidHeader = TRUE,
                plotOutput(ns("plot_region"))
              )
            )
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
mod_dashboard_server <- function(id, wines){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    shelf_slot_cap <- reactiveVal(6)

    output$total_amount <- renderText({
      sum(wines()$bottle_count)
    })

    output$mean_age <- renderText({
      weighted.mean(Sys.Date() |> format("%Y") |> as.numeric() -
                      wines()$vintage, wines()$bottle_count) |>
        paste("Jahre")
    })

    output$max_age <- renderText({
      max(Sys.Date() |> format("%Y") |> as.numeric() - wines()$vintage) |>
        paste("Jahre")
    })

    output$most_frequent_region <- renderText({
      wines() |>
        dplyr::count(region, wt = bottle_count) |>
        dplyr::arrange(dplyr::desc(n)) |>
        dplyr::slice(1) |>
        dplyr::pull(region)
    })

    output$plot_vintage <- renderPlot({
      ggplot2::ggplot(wines(), ggplot2::aes(x = factor(vintage))) +
        ggplot2::geom_bar(ggplot2::aes(weight = bottle_count), fill = "steelblue") +
        ggplot2::labs(
          x = "Jahrgang",
          y = "Flaschenanzahl"
        ) +
        ggplot2::theme_minimal()
    })

    output$plot_region <- renderPlot({
      wines() |>
        dplyr::group_by(region) |>
        dplyr::summarize(total_bottles = sum(bottle_count)) |>
        dplyr::ungroup() |>
        ggplot2::ggplot(ggplot2::aes(x = "", y = total_bottles, fill = region)) +
        ggplot2::geom_bar(width = 1, stat = "identity") +
        ggplot2::coord_polar("y") +
        ggplot2::labs(
          fill = "Region",
          x = NULL,
          y = NULL
        ) +
        ggplot2::theme_void() +
        ggplot2::theme(
          legend.position = "right",
          legend.title = ggplot2::element_text(size = 14),
          legend.text = ggplot2::element_text(size = 12)
        )
    })

    mod_wines_server("wines_1", wines, shelf_slot_cap)
  })
}

## To be copied in the UI
# mod_dashboard_ui("dashboard_1")

## To be copied in the server
# mod_dashboard_server("dashboard_1")
