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
