library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(DT)
library(googleVis)


VGdata = read.csv("./VGdataCleaned.csv") # must be in R app folder
VGdata$X = NULL



