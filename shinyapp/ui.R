#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

dashboardPage(
    # App title
    dashboardHeader(
        title = "Video Game Data Visualization",
        titleWidth = 300),
    # sidebar panel
    dashboardSidebar(width = 300,
        sidebarUserPanel(name = "Casey Hoffman"), # add img from www subfolder
        sidebarMenu(
            # intro: why this matters, basic graph to kick off
            menuItem("Introduction", tabName = "intro", icon = icon("info-circle")),
            # sales by....
            menuItem("Sales by Region", tabName = "sales", icon = icon("globe-americas")),
            # user/critic ratings
            menuItem("User and Critic Ratings", tabName = "ratings",
                     icon = icon("thumbs-up")),
            # platforms...
            menuItem("Platforms", tabName = "platforms", icon = icon("gamepad"))
            # user vs critic scores
        )
    ),
    
    # body
    dashboardBody(
        tabItems(
            tabItem(tabName = "intro",
                    fluidRow(
                        box("Intro here")),
                    fluidRow(width = 12,
                        box(plotOutput("years")))
                    ),
            
            tabItem(tabName = "sales",
                    fluidRow(
                        box(title = "Units Sold by Genre and Region",
                            width = 12,
                            plotOutput("mosaic")),
                        box(plotOutput("propregion")))
                    ),
            tabItem(tabName = "ratings",
                    fluidRow(
                        box(title = "Scatterplot of User vs Critic Score, by Genre",
                            plotOutput("score.scatter")),
                        box(title = "Relationship between Scores and Units sold (millions)",
                            plotOutput("scores.corrs"))
                    )),
            tabItem(tabName = "platforms",
                    fluidPage(
                        titlePanel("Explore for yourself!"),
                        
                        # select which syst
                        fluidRow(
                            column(4, 
                                   selectInput("platform", 
                                               "Platform:",
                                               c("All", unique(as.character(topGames$Platform))))
                                   )
                            ),
                        # table on its own row
                        fluidRow(box(DT::dataTableOutput("table"),
                            width = 12))
                           
                        
                    )
             )
        )
    )
)
        
        
        

