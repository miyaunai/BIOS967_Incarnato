parents=read.csv("Paramecium_Phenotype_Data_Parents.csv")
offspring=read.csv("Paramecium_Phenotype_Data.csv")

parents
offspring

View(parents)
View(offspring)

library(tidyverse)

offspring_mean=offspring %>% group_by(file) %>% summarise(area=mean(mean_area))

offspring_id=pull(offspring_mean, file)
offspring_id

offspring_id %>% 


unique(parents$file)

parents_mean=parents%>%group_by(file) %>% 
  summarise(area=mean(mean_area)) %>%
  mutate(parents_id=str_replace(file, "M_PC_23_G_", ""))

#parents_id=pull(parents_mean, file) %>% str_replace("M_PC_23_G_", "")


##
unique(offspring$file)
