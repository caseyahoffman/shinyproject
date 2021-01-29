library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(DT)
library(googleVis)


VGdata = read.csv("./VGdataCleaned.csv", stringsAsFactors = T) # must be in R app folder
VGdata = VGdata %>%
  mutate(Name = as.character(Name), X = NULL)

state_stat <- data.frame(state.name = rownames(state.x77), state.x77)
# remove row names
rownames(state_stat) <- NULL
# create variable with col names as choice
choice <- colnames(state_stat)[-1] # dont include the state name col
