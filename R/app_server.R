#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  df <- data.frame(
    rowid = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20),
    shelf_slot = c("101", "202", "303", "404", "505", "506", "607", "708", "809", "910",
                   "111", "212", "313", "414", "515", "616", "717", "818", "919", "1020"),
    bottle_count = c(1, 3, 1, 2, 1, 2, 1, 4, 1, 2,
                     2, 3, 1, 2, 1, 3, 2, 1, 4, 3),
    vintage = c(2015, 2018, 2019, 2016, 2020, 2017, 2012, 2015, 2011, 2014,
                2013, 2010, 2011, 2018, 2019, 2009, 2012, 2008, 2020, 2016),
    variety = c("Riesling", "Cabernet Sauvignon", "Spätburgunder", "Sangiovese", "Malbec",
                "Chardonnay", "Merlot", "Syrah", "Zinfandel", "Pinot Noir",
                "Tempranillo", "Grenache", "Nebbiolo", "Barbera", "Chenin Blanc",
                "Pinot Grigio", "Gewürztraminer", "Sauvignon Blanc", "Viognier", "Torrontés"),
    name = c("Müller Thurgau", "Margaux", "Schmidt Pinot Noir", "Sassicaia", "Catena Alta",
             "Chablis", "Château Petrus", "Hermitage", "Ridge Zin", "La Tâche",
             "Vega Sicilia", "Châteauneuf-du-Pape", "Barolo", "Barbera d'Alba", "Vouvray",
             "Santa Margherita", "Trimbach", "Cloudy Bay", "Condrieu", "Colomé"),
    winery = c("Weingut Müller", "Château Margaux", "Weingut Schmidt", "Tenuta San Guido", "Bodega Catena Zapata",
               "Domaine Laroche", "Château Petrus", "M. Chapoutier", "Ridge Vineyards", "Domaine de la Romanée-Conti",
               "Bodegas Vega Sicilia", "Château Rayas", "Gaja", "Pio Cesare", "Domaine Huet",
               "Santa Margherita", "Maison Trimbach", "Cloudy Bay Vineyards", "E. Guigal", "Bodega Colomé"),
    region = c("Mosel", "Bordeaux", "Pfalz", "Toskana", "Mendoza",
               "Chablis", "Pomerol", "Rhône", "California", "Burgundy",
               "Ribera del Duero", "Rhône", "Piedmont", "Piedmont", "Loire",
               "Veneto", "Alsace", "Marlborough", "Rhône", "Salta"),
    country = c("Deutschland", "Frankreich", "Deutschland", "Italien", "Argentinien",
                "Frankreich", "Frankreich", "Frankreich", "USA", "Frankreich",
                "Spanien", "Frankreich", "Italien", "Italien", "Frankreich",
                "Italien", "Frankreich", "Neuseeland", "Frankreich", "Argentinien")
  )

  wines <- reactiveVal(df)

  mod_dashboard_server("dashboard_1", wines)
}
