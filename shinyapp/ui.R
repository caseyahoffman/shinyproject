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
            menuItem("Platforms", tabName = "platforms", icon = icon("gamepad")),
            menuItem("Source code", icon = icon("git"), 
                              href = "https://github.com/caseyahoffman/shinyproject/", newtab = T)
        )
    ),
    
    # body
    dashboardBody(
        tabItems(
            # Intro tab
            tabItem(tabName = "intro",
                    h2("About this Project"),
                    fluidRow(
                        box(title = "Background", status = "primary", solidHeader = T,
                            "For this project I have found a dataset of video game sales and ratings information.
                            The video game industry is one of the most popular -- overshadowing both movies and TV in sales. 
                            Given the massive revenue and overall popularity of this industry, I was curious what trends could be uncovered by
                            investigating patterns in sales, grouped by genre and global region. I am also interested in user and critic
                            rating scores: whether the two are correlated in some way, and if either impacts sales.",
                            width = 6),
                        box(title = "Big Questions:", status = "primary", solidHeader = T,
                            "1. Do different regions have a preference for certain genres?", br(),
                            "2. Are user ratings associated with critic ratings?", br(),
                            "3. Do user or critic ratings have an impact on sales?", br(),
                            "The goal of this project is to provide actionable insights that motivate intelligent investment decisions.
                            For example, if a certain region has a clear interest in a particular genre, this region may be profitable to advertise in.",
                            width = 6)),
                    fluidRow(
                        box(title = "Overall Units Sold: 1996-2016", status = "success", solidHeader = T,
                            plotOutput("years"), width = 12))
                    ),
            # Sales by Region & Genre
            tabItem(tabName = "sales",
                    h2("Sales by Region & Genre"),
                    fluidRow(
                        box(title = "By Proportion:", status = "success", solidHeader = T,
                            plotOutput("propregion"), width = 9),
                        box(title = "Description", status = "primary", solidHeader = T, width = 3,
                        "I produced a stacked bar chart displaying the proportion of units sold. Each
                        bar represents a genre; each color is that region's proportions of units sold there.", br(), 
                        "For example: it appears players in Japan buy disproportionately large amounts of games in the 
                        Role-Playing and Puzzle genres, and disproportionally small amounts of games in the Shooter 
                        and Sports genres.", br(), "Since this plot can be difficult to interpret, I subsequently produced a mosaic plot.")),
                    fluidRow(
                        box(title = "Description:", status = "primary", solidHeader = T, width = 3,
                            "This mosaic plot displays the proportion of each combination of two discrete variables.
                            In this instance, each row is a genre and each column is a region. This allows for easier 
                            interpretation of the relative proportions of each genre, across regions.", br(),
                            "My interpretation of this mosaic plot is that users in Europe and North America have similar preferences, 
                            in regards to game genre. Moreover, it seems users in Japan have unique tastes in preferred genres. It might 
                            be worthwhile to adapt a novel marketing strategy when targeting this region."),
                        box(title = "Mosaic Plot of Genre and Region (Weighted by Units Sold)", status = "success", solidHeader = T,
                            width = 9, plotOutput("mosaic")))
                    ),
            # Ratings
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
                                               c("All", unique(as.character(gametbl$Platform))))
                                   ),
                            column(4, 
                                   selectInput("rgn", 
                                               "Region:", 
                                              c(unique(as.character(gametbl$Region)))
                                               ))
                            ),
                        # table on its own row
                        fluidRow(box(DT::dataTableOutput("table"),
                            width = 12))
                           
                        
                    )
             )
        )
    )
)
        
        
        

