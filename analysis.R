parents=read.csv("Paramecium_Phenotype_Data_Parents.csv")
offspring=read.csv("Paramecium_Phenotype_Data.csv")

parents
offspring

View(parents)
View(offspring)

library(tidyverse)

unique(offspring$file)

offspring_mean=offspring %>% group_by(file) %>% 
  summarise(area=mean(mean_area)) %>%
    mutate(offspring_id=str_replace(file, "M_F2_", ""))    
    
offspring_id=pull(offspring_mean, file)
offspring_id

parent1=offspring_id %>% str_replace("M_F2_", "") %>% str_split("x", simplify=T) 
p1=parent1[,1]

parent2=parent1[,2] %>% str_split("_", simplify=T) 
p2=parent2[,1]

offspring_mean=offspring_mean %>% mutate(parent1=p1) %>% mutate(parent2=p2) %>% mutate(offspring_area=area) %>% select(-area)


unique(parents$file)

parents_area=parents%>%group_by(file) %>% 
  summarise(area=mean(mean_area)) %>%
  mutate(parents_id=str_replace(file, "M_PC_23_G_", "")) %>%
  select(-file)

area_data=offspring_mean %>% left_join(., parents_area, by=join_by(parent1==parents_id)) %>%
left_join(., parents_area, by=join_by(parent2==parents_id)) %>% 
  mutate(midparent_area=(area.y+area.x)/2)


#parents_id=pull(parents_mean, file) %>% str_replace("M_PC_23_G_", "")

po_reg_area<-glm(area_data$offspring_area~area_data$midparent_area)

ggplot(data=area_data,aes(x=midparent_area, y=offspring_area))+
  geom_point()+
  geom_smooth(method=glm)

po_reg_area<-glm(area_data$offspring_area~area_data$midparent_area)
 anova(po_reg_area)

