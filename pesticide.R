id_info <- Farmer_info %>% select(id, country, year_season, tropical_season)

temp <- PestManagementData %>% select(id, apply.x, wm_method,  id_act_ingr.x, devel_stage.x, mix_type.x, id_pest, id_act_ingr.y, pest_type, apply.y, devel_stage.y, days_applied, mix_type.y, id_fungicide, apply)

# weed manangement
weedMang <- PestManagementData %>% select(id, apply.x, wm_method,  id_act_ingr.x, devel_stage.x, mix_type.x)

weedMang <- weedMang[!duplicated(weedMang), ]

weedMang <- left_join(weedMang, active_ingr, by = c("id_act_ingr.x" = "id_act_ingr")) %>% select(id, wm_method, active_ingr, devel_stage.x, mix_type.x)

weedMang <- weedMang[!is.na(weedMang$wm_method), ]

weedMang[is.na(weedMang$active_ingr), "active_ingr"] <- "Hand-weeding"

weedMang <-  weedMang %>% 
        left_join(id_info, by = "id") %>%
        left_join(dev_stage, by = c("devel_stage.x" = "id_dev_stage")) %>%
        select(id,country, year_season, tropical_season, active_ingr, dev_stage_code)


weedMang %>% filter(country == "VN") %>% str()

weedMang %>%
        filter(!herb == "0", !level == "NA" ) %>%
        group_by(location, year, season, herb, wmg.dvs, level, nofarmers) %>%        
        summarise(n.herb.app = n()) %>%
        mutate(freq = n.herb.app/nofarmers) %>%ggplot(., aes(x= herb, y = freq, fill = herb)) + 
        geom_bar(stat = "identity") + 
        facet_grid(level ~ wmg.dvs, scale = "free" , space ="free") + 
        ylim(0,1) + 
        ggtitle(paste("Herbicide Application in", country, "from Survey Data \nin", sseason, "2013 to 2014", sep = " ")) + mytheme + xlab(" Herbicide") + ylab("No. Applications Normalized by No. Farmers/Group\n (applications/season)") + scale_fill_brewer(palette= "Set3", name = "Active ingredient")# +  theme(legend.position = "right")












# insecticide application
insectMang <-  PestManagementData %>% select(id, apply.y, id_act_ingr.y, devel_stage.y, mix_type.y)

#insectMang <-  PestManagementData %>% filter(id == 19) %>% select(id, apply.y, id_act_ingr.y, devel_stage.y, mix_type.y)
 
# remove the dplicate row
insectMang <- insectMang[!duplicated(insectMang), ]

Chem_app <- left_join(insectMang, active_ingr, by = c("id_act_ingr.y" = "id_act_ingr")) %>% select(id, pest_type, active_ingr, devel_stage.y, mix_type.y)


# pest_type == 3 is molluscicide
mollusicide <- Chem_app %>% filter(pest_type == 3)

insecticide <- Chem_app %>% filter(pest_type == 6)

fungicide <- Chem_app %>% filter(pest_type == 7)

temp2 <- fungicide %>% filter(mix_type.y == 3)

temp3 <- temp2 %>% group_by(id, devel_stage.y) %>% summarise(fre = n())

ifpaste(temp2[, "active_ingr"], sep = ",")

#temp3
#%>% group_by(devel_stage.y) %>% 

# weed 


        

