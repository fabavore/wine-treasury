#' wines UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_wines_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' wines Server Functions
#'
#' @noRd 
mod_wines_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_wines_ui("wines_1")
    
## To be copied in the server
# mod_wines_server("wines_1")
