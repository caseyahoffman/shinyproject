library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(DT)
library(ggmosaic) # devtools::install_github("haleyjeppson/ggmosaic")


VGdata = read.csv("./VGdataCleaned.csv") # must be in R app folder
VGdata$X = NULL


