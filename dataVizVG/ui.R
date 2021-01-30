# ui.R

shinyUI(
    dashboardPage(
    dashboardHeader(title = "Video Game Rating and Sales Analysis"),
    dashboardSidebar(
        sidebarUserPanel("Casey Hoffman", image = "kirb.jpg"), # image = local file in www subfolder
        sidebarMenu(
            menuItem("Introduction", tabName = "intro", icon = icon("info-circle")),
            menuItem("Data Table", tabName = "data", icon = icon("database"))),
        selectizeInput("selected", "Select item to display", choice)
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "intro", 
                    fluidRow(" something here")),
                  
             tabItem(tabName = "data",
                    #datatable
                    fluidRow(box(DT::dataTableOutput("table"),
                                 width = 12))))
    )
))
