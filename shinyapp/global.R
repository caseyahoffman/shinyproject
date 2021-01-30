library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(DT)
library(ggmosaic) # devtools::install_github("haleyjeppson/ggmosaic")


VGdata = read.csv("./VGdataCleaned.csv") # must be in R app folder
VGdata$X = NULL


gametbl = VGdata[VGdata$Region == "Global_Sales", ]
gametbl = gametbl %>% 
  select(Name, Platform, Genre, Units_Sold, User_Score, Critic_Score, Year, Rating)

