#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$years <- renderPlot({
        VGdata %>%
            filter(Region != "Global") %>% 
            ggplot(aes(x = reorder(Region, -Units_Sold), y = Units_Sold)) +
            geom_bar(aes(fill = Region), stat = "identity") +
            xlab("Global Region") +
            ylab("Units Sold (in millions)") +
            ggtitle("Units sold (in millions), 1996-2016") +
            theme(axis.text.x = element_blank())
        
    })
    
    output$mosaic <- renderPlot({
        VGdata %>% 
            filter(Region != "Global") %>%
            ggplot() +
            geom_mosaic(aes(
                x = product(Genre, Region), 
                fill = Genre, weight = Units_Sold))
        
    })
    
    output$propregion <- renderPlot({
        VGdata %>%
            filter(Region != "Global") %>%
            ggplot(aes(x = Genre, y = Units_Sold)) +
            geom_bar(aes(fill = Region), stat = "identity", position = "fill") +
            ylab("Proportion of Units Sold") +
            coord_flip() +
            ggtitle("Proportion of Units Sold, by Genre and Region")
        
    })
    
    output$plot1 <- renderPlot({
        VGdata %>% 
            filter(Region != "Global") %>% 
            ggplot(aes(fill = Region)) +
            geom_col(aes(x = reorder(Region, -Units_Sold), y = Units_Sold), position = "dodge") +
            facet_wrap(~ Genre) +
            scale_fill_discrete(name = "Regions", 
                                labels = c("Europe", "Japan", "N. America", "Other")) +
            ylab("Units sold (in millions)") +
            theme(axis.text.x = element_blank())
    })
    
    output$score.scatter <- renderPlot({
        VGdata %>%
            filter(Region == "Global") %>% 
            ggplot(aes(x = User_Score, y = Critic_Score)) + 
            geom_point(size = 0.5) + 
            geom_smooth(aes(color = Genre), method = lm, se = FALSE) + 
            facet_wrap(~ Genre) +
            xlab("User Score (1-100)") + 
            ylab("Critic Score (1-100)")
    })
    
    output$scores.corrs <- renderPlot({
        VGdata %>% 
            filter(Region == "Global") %>%
            pivot_longer(cols = c(User_Score, Critic_Score), names_to = "Rating_Type",
                         values_to = "Score") %>% 
            ggplot(aes(x = Score, y = Units_Sold)) + geom_smooth(aes(color = Rating_Type), method = "lm", se = FALSE) +
            xlab("Games' Scores by User & Critic (1-100)") +
            ylab("Units Sold") +
            ggtitle("Correlation between User/Critic Score & Units Sold") +
            facet_wrap(~ Genre)
        
    }) 
    
    
    
    output$table <- DT::renderDataTable(DT::datatable({
        if (input$platform != "All") {
            gametbl <- gametbl[gametbl$Platform == input$platform,]
        } 
        if (input$rgn != "All") {
            gametbl <- gametbl[gametbl$Region == input$rgn, ]
        }
        gametbl
    }, rownames = FALSE))
    
    
    output$topGame <- renderInfoBox({
        infoBox(
            "Best-Selling Game Overall", paste0(gametbl$Name[1]), icon = icon("game-console-handheld"),
            color = "red", fill = TRUE)
    })
    
    
    output$value <- renderPrint({ input$system })




})
