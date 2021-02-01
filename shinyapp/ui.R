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
        sidebarUserPanel(name = "Casey Hoffman", image = "me.jpg"), 
        sidebarMenu(
            # intro: why this matters, basic graph to kick off
            menuItem("Introduction", tabName = "intro", icon = icon("info-circle")),
            # sales by....
            menuItem("Sales by Region", tabName = "sales", icon = icon("globe-americas")),
            # user/critic ratings
            menuItem("User and Critic Ratings", tabName = "ratings",
                     icon = icon("thumbs-up")),
            # rating vs sales glm
            menuItem("Ratings vs Sales", tabName = "glmtab", icon = icon("chart-line")),
            # platforms...
            menuItem("Platforms", tabName = "platforms", icon = icon("gamepad")),
            # linkedin
            menuItem("LinkedIn", icon = icon("linkedin"),
                     href = "https://www.linkedin.com/in/caseyahoffman/", newtab = T),
            # link to my github!
            menuItem("Source code", icon = icon("git"), 
                     href = "https://github.com/caseyahoffman/shinyproject/", newtab = T),
            menuItem("Dataset access", icon = icon("external-link"),
                     href = "https://www.kaggle.com/rush4ratio/video-game-sales-with-ratings", newtab = T)
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
                    h2("Relationship between User and Critic Ratings"),
                    fluidRow(
                        box(title = "Scatterplot of User vs Critic Score, by Genre", status = "success",
                            solidHeader = T, width = 12, plotOutput("score.scatter"))),
                    fluidRow(
                        box(title = "Description:", status = "primary", solidHeader = T, width = 12,
                            "To determine whether there was a relationship between user and critic ratings, I produced a scatterplot of these scores,
                            divided by genre. Each scatterplot is fitted with a linear regression line to provide a visual indicator of the overall trends.
                            It is worthwhile to note that non-linear models may provide a more accurate depiction of the relationship.", br(),
                            "For all genres, there is a positive, linear relationship between user and critic rating. This indicates that in general,
                            higher user scores can suggest higher critic scores, and that the two ratings are somewhat consistent.", br(),
                            "However, the strength of this relationship varies by genre. Strategy games, for example, have a relatively weak association,
                            whereas puzzle games have a relatively strong association."))
                      ),
            # Ratings on Sales
            tabItem(tabName = "glmtab",
                    h2("Relationship between User/Critic Ratings and Units Sold"),
                    fluidRow(
                        box(title = "Relationship between Scores and Units sold (millions)", status = "success",
                            solidHeader = T, width = 12, plotOutput("scores.corrs"))
                       ),
                    fluidRow(
                        box(title = "Do ratings matter?", status = "primary", solidHeader = T, width = 12,
                            "Across areas of multimedia entertainment, there is often some discrepancy between critic and consumer scores. This may be
                            due to different rating criteria -- a critic might be concerned with if a game is of excellent quality, a user may be concerned
                            with if a game is enjoyable to play. From a business perspective, it is criticial to know if either type of rating impacts sales.
                            If it is found that user ratings seems to be of substantial effect, developers may wish to reach out to users and solicit reviews.", br(), 
                            "For each genre, I produced a linear regression line to display the relationship between 1) user score and units sold, displayed in blue, 
                            and 2) critic score and units sold, displayed in red.", br(), 
                            "Across all genres, critic scores have a stronger relationship with units sold than user scores. This suggests that to a potential user,
                            critics' ratings may be influential in determining if a sale is made.
                            For the Shooter genre, it appears that user ratings are not associated at all with sales, but critic ratings are. This suggests that especially for this genre,
                            user ratings are not influential when making a purchasing decision, but that critic ratings may be taken into account.", br(),
                            "Adventure and Strategy game sales are not affected much by either rating type, suggesting purchases in these genres are not 
                            contingent on critical acclaim. There is a substantially strong relationship between critic scores and units sold, for Action games, 
                            suggesting that critics' ratings are strongly taken into consideration strongly.")
                    )
                    ),
            # Platforms 
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
                                               )),
                            infoBoxOutput("topGame"),
                            ),
                        # table on its own row
                        fluidRow(box(DT::dataTableOutput("table"),
                            width = 12))
                           
                        
                    )
             )
        )
    )
)
        
        
        

