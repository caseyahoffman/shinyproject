# This is a pre-processing file to clean the dataset before creation of the shiny app.
library(tidyverse)
VGdata = read.csv("./VGdata.csv")

# Convert factor columns to the correct type
# Year becomes factor type so it is not treated as numeric(continuous) - used as a grouping variable

VGdata = VGdata %>% 
  rename(Year = Year_of_Release) %>%
  mutate(Year = as.factor(Year), # so it is not treated as continuous in plotting
         Platform = as.factor(Platform),
         Genre = as.factor(Genre),
         Publisher = as.factor(Publisher))

# remove the rows with missing data - we want only complete entries
# Now, we can also fix the variables that could not be properly mutated w/ NAs
# Critic scores are on a scale of 1-100; user scores are on a scale of 1-10 - I multiply the user score by 10 to standardize the ratings
VGdata = VGdata %>% 
  drop_na() %>% 
  mutate(Developer = as.factor(Developer),
         Rating = as.factor(Rating),
         User_Score = as.numeric(User_Score) * 10)

VGdata = VGdata %>% filter(Rating != "" & Developer != "") # no blanks

write.csv(VGdata, file = "./VGdataCleaned.csv")
