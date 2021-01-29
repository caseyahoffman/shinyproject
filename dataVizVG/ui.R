# ui.R

shinyUI(
    dashboardPage(
    dashboardHeader(title = "Video Game Rating and Sales Analysis"),
    dashboardSidebar(
        sidebarUserPanel("Casey Hoffman", image = "kirb.jpg"), # image = local file in www subfolder
        sidebarMenu(
            menuItem("Map", tabName = "map", icon = icon("map")),
            menuItem("Data", tabName = "data", icon = icon("database"))),
        selectizeInput("selected", "Select item to display", choice)
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "map", 
                    fluidRow(infoBoxOutput("maxBox"),
                             infoBoxOutput("minBox"),
                             infoBoxOutput("avgBox")),
                    #gvisGeoChart
                    fluidRow(box(htmlOutput("map"),
                                 height = 300),
                             #gvisHistoGram
                             box(htmlOutput("hist"),
                                 height = 300))),
            tabItem(tabName = "data",
                    #datatable
                    fluidRow(box(DT::dataTableOutput("table"),
                                 width = 12))))
    )
))
