#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

# --- LOAD PACKAGES ---

library(shiny)
library(bslib)
library(ggplot2)
library(ggpie)

# --- LOAD HELPERS/SOURCE DATA ---

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Cash Grab Arena - Playtest Data Dashboard"),
    
    #Create individual tabs for playtesting data
    navset_pill(
      
      #About tab: discuss the premise and purpose of this dashboard
      nav_panel("About",
                
                sidebarPanel(div("This dashboard was built to have a way to easily view playtesting data related to",
                                 a("Cash Grab Arena.", href = "https://github.com/HazilTheNut/cashgrab")),
                             div("Data displayed in this dashboard was gathered from Cash Grab Arena version 0.12.0 or later."),
                             div("Data here is primarily focused on the focal gameplay aspects of Cash Grab Arena: classes and trinkets."),
                             div("Cash Grab Arena was made by HazilTheNut. This dashboard was built by Makse.")),
                img(src = "goldnugget.png", align = "center")
                ),
      
      #Class Data tab: display data where the Class is the main focus
      nav_panel("Class Data",
                
                #Sidebar to select data from
                sidebarPanel(
                  
                  #Select the viewset, default KPE.
                  selectInput("chooseClassVis", "Choose a View", 
                              choices = c("Kills per Entry", "Coins per Entry", "Class Usage", "Deaths by Class"),
                              selected = "Kills per Entry"),
                  
                  #Conditional: allow user to facet by Trinket Usage
                  conditionalPanel(
                    condition = "input.chooseClassVis == 'Kills per Entry' || input.chooseClassVis == 'Coins per Entry' || input.chooseClassVis == 'Deaths by Class'",
                    checkboxInput("groupByTrinket", "Group by Trinket Usage", FALSE)
                  ),
                  
                )
                
                ),
      
      #Trinket Data tab: display data where the Trinket is the main focus
      nav_panel("Trinket Data",
                
                #Sidebar to select data from
                #Select the view, default KPE.
                sidebarPanel(
                  selectInput("chooseTrinketVis", "Choose a View", 
                              choices = c("Kills per Entry", "Coins per Entry", "Trinket Usage"),
                              selected = "Kills per Entry"),
                  
                  #Conditional: allow user to facet by Class Usage
                  conditionalPanel(
                    condition = "input.chooseTrinketVis == 'Trinket Usage'",
                    checkboxInput("groupByTrinket", "Group by Class", FALSE)
                  ),
                )
                
                
                )
      
    )
    
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
