
temp <- PestManagementData %>% filter(id %in% p.key) %>% select(id, apply.x, wm_method,  id_act_ingr.x, devel_stage.x, mix_type.x, id_pest, id_act_ingr.y, pest_type, apply.y, devel_stage.y, days_applied, mix_type.y, id_fungicide, apply)


weedMang <- PestManagementData %>% filter(id %in% p.key) %>% select(id, apply.x, wm_method,  id_act_ingr.x, devel_stage.x, mix_type.x)

insectMang <-  PestManagementData %>% filter(id %in% p.key) %>% select(id, apply.y, id_act_ingr.y, devel_stage.y, mix_type.y)


insectMang <-  PestManagementData %>% filter(id == 19) %>% select(id, apply.y, id_act_ingr.y, devel_stage.y, mix_type.y)
 
# remove the dplicate row
insectMang <- insectMang[!duplicated(insectMang), ]

temp <- left_join(insectMang, active_ingr, by = c("id_act_ingr.y" = "id_act_ingr")) %>% select(id, devel_stage.y, active_ingr, mix_type.y)


temp2 <- temp %>% filter(mix_type.y == 2)

temp3 <- paste(temp2[, "active_ingr"], sep = ",")

temp3
%>% group_by(devel_stage.y) %>% 
        
        
        
        dat = data.frame(title = c("title1", "title2", "title3"),
                         author = c("author1", "author2", "author3"),
                         customerID = c(1, 2, 1))

aggregate(dat[-3], by=list(dat$customerID), c)

aggregate(temp2$active_ingr, by=list(temp2$mix_type.y), e)



        

