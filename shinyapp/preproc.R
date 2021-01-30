# This is a pre-processing file to clean the dataset before creation of the shiny app.
library(tidyverse)
VGdata = read.csv("./VGdata.csv")

# Convert factor columns to the correct type
# remove NA's
# Critic scores are on a scale of 1-100; user scores are on a scale of 1-10 - I multiply the user score by 10 to standardize the ratings

VGdata = VGdata %>% 
  drop_na() %>% 
  rename(Year = Year_of_Release) %>%
  mutate(Platform = as.factor(Platform),
         Genre = as.factor(Genre),
         Publisher = as.factor(Publisher),
         Developer = as.factor(Developer),
         Rating = as.factor(Rating),
         User_Score = as.numeric(User_Score) * 10)

# remove blanks - what the NA function did not recognize
VGdata = VGdata %>%
  filter(Rating != "" & Developer != "")
  
# fix the "sales"
VGdata = VGdata %>% pivot_longer(cols = ends_with("Sales"),
                                 names_to = "Region", values_to = "Units_Sold")



write.csv(VGdata, file = "./VGdataCleaned.csv")
