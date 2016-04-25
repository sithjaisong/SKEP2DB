
id_info <- survey %>% select(id, prod_env, year, season, farmer_type, no_farmer)

#temp <- PestManagementData %>% select(id, apply.x, wm_method,  id_act_ingr.x, devel_stage.x, mix_type.x, id_pest, id_act_ingr.y, pest_type, apply.y, devel_stage.y, days_applied, mix_type.y, id_fungicide, apply)

# ======================= Weed manangement =============================

weedMang <- PestManagementData %>% select(id, apply.x, wm_method,  id_act_ingr.x, devel_stage.x, mix_type.x)

weedMang <- weedMang[!duplicated(weedMang), ]

weedMang <- left_join(weedMang, active_ingr, by = c("id_act_ingr.x" = "id_act_ingr")) %>% select(id, wm_method, active_ingr, devel_stage.x, mix_type.x)

weedMang <- weedMang[!is.na(weedMang$wm_method), ]

weedMang[is.na(weedMang$active_ingr), "active_ingr"] <- "Hand-weeding"

weedMang <-  weedMang %>% 
        left_join(id_info, by = "id") %>%
        left_join(dev_stage, by = c("devel_stage.x" = "id_dev_stage")) %>%
        select(id, prod_env, year, season, farmer_type , no_farmer, active_ingr, dev_stage_code)

weedMang <- weedMang %>% transform(prod_env = as.factor(prod_env),
                        year = as.factor(year),
                       season = as.factor(season),
                       farmer_type = as.factor(farmer_type),
                       active_ingr = as.factor(active_ingr),
                       dev_stage_code = as.factor(dev_stage_code))

weedMang$dev_stage_code <- factor(weedMang$dev_stage_code, levels = c("PW", "PD", "LV", "SO","TR","ET", "AT", "MT", "PI", "PF", "SD", "ME", "HD", "AR", "HA"))

weedMang$farmer_type <- factor(weedMang$farmer_type, levels = c("adopter", "majority", "drifter"))

#weedMang$no_farmer <- 15

#test <- weedMang %>% group_by(country, year_season, tropical_season) %>% mutate(no_farmer = n()) %>% arrange(country, year_season, tropical_season)
source("mytheme.R")


# weed_x <- weedMang %>% 
#         filter(prod_env == prod_env.name[1]) %>% 
#         group_by(prod_env) %>%
#         mutate(total_farmer = n()) %>%
#         group_by(prod_env, year) %>% 
#         mutate(no_farmer = n()) %>%
#         group_by(prod_env, farmer_type) %>%
#         mutate(no_fre_ftype = n()) %>%
#         group_by(prod_env, year, active_ingr, dev_stage_code) %>%        
#         mutate(n.herb.app = n(), freq_total = n.herb.app/total_farmer)

# select the production environment 1 to 5 as the below
# 1."West_Java"
# 2."Odisha"
# 3."Tamil_Nadu"
# 4."Central_Plain" 
# 5. "Red-river_delta"
weed_x <- weedMang %>% 
        filter(prod_env == prod_env.name[5]) %>%
        group_by(season, farmer_type) %>%
        mutate(no_fre_ftype = n()) %>%
        group_by(season, farmer_type, active_ingr, dev_stage_code) %>%        
        mutate(n.herb.app = n(), freq_ftype = n.herb.app/no_fre_ftype)

weed_x[!duplicated(weed_x[, c("prod_env", "season", "farmer_type", "active_ingr", "dev_stage_code")]), ] %>%
        ggplot(., aes(x= active_ingr, y = freq_ftype, fill = active_ingr))+ 
        geom_bar(stat = "identity") + 
        mytheme +
        facet_grid(season ~ dev_stage_code, scale = "free" , space ="free") + 
        ylim(0, 1) + ylab("Proportion") + xlab("Active ingredient")

#========================= Insecticide ================================= 

# combine with

# insecticide application
PestMang <-  PestManagementData %>% select(id, apply.y, id_act_ingr.y, devel_stage.y, mix_type.y)

#insectMang <-  PestManagementData %>% filter(id == 19) %>% select(id, apply.y, id_act_ingr.y, devel_stage.y, mix_type.y)
 
# remove the dplicate row
PestMang <- PestMang[!duplicated(PestMang), ] %>% left_join(id_info, by = "id") %>%
        left_join(dev_stage, by = c("devel_stage.y" = "id_dev_stage")) %>%
        left_join(., active_ingr, by = c("id_act_ingr.y" = "id_act_ingr")) %>% 
        select(id, prod_env, year, season, farmer_type, no_farmer, pest_type, active_ingr, dev_stage_code, mix_type.y)

PestMang$dev_stage_code <- factor(PestMang$dev_stage_code, levels = c("SO","TR","ET", "AT", "MT", "PI", "SD","ME","HD","AR","HA"))
PestMang$farmer_type <- factor(PestMang$farmer_type, levels = c("adopter", "majority", "drifter"))

# pest_type == 3 is molluscicide
#mollusicide <- PestMang %>% filter(pest_type == 3)

insecticide <- PestMang %>% filter(pest_type == 6) %>%
        filter(prod_env == prod_env.name[5]) %>%
        group_by(season, farmer_type) %>%
        mutate(no_fre_ftype = n()) %>%
        group_by(season, farmer_type, active_ingr, dev_stage_code) %>%        
        mutate(n.insect.app = n(), freq_ftype = n.insect.app/no_fre_ftype)

insecticide[!duplicated(insecticide[, c("prod_env", "season" ,"farmer_type", "active_ingr", "dev_stage_code")]), ] %>% ggplot(., aes(x= active_ingr, y = freq_ftype))+ 
        geom_bar(stat = "identity") + 
        theme(panel.background = element_blank(),
              axis.text.x = element_text(size = 14, color = "black", angle = 90, hjust = 0, vjust = 1),
              axis.title.x = element_text(size =14, color = "black", vjust = -0.5),
              legend.position = "none", 
              axis.title.y = element_text(size =14, color = "black", vjust = 1),
              plot.title = element_text(size = 18, color = "black", vjust = 2.5),
              strip.text = element_text(face = "bold", size = rel(1))
        ) +
        facet_grid(farmer_type*season ~ dev_stage_code, scale = "free" , space ="free") + 
        ylim(0,1)  + ylab("Frequency") + xlab("Active ingredient")


# ==========fucgicide ===================
fungicide <- PestMang %>% filter(pest_type == 7) %>%
        filter(prod_env == prod_env.name[5]) %>%
        group_by(season, farmer_type) %>%
        mutate(no_fre_ftype = n()) %>%
        group_by(season, farmer_type, active_ingr, dev_stage_code) %>%        
        mutate(n.fungi.app = n(), freq_ftype = n.fungi.app/no_fre_ftype)

fungicide[!duplicated(fungicide[, c("prod_env", "season","farmer_type", "active_ingr", "dev_stage_code")]), ] %>% ggplot(., aes(x= active_ingr, y = freq_ftype, fill = active_ingr))+ 
        geom_bar(stat = "identity") + 
        theme(panel.background = element_blank(),
              axis.text.x = element_text(size = 14, color = "black", angle = 90, hjust = 0, vjust = 0.5),
              axis.title.x = element_text(size =14, color = "black", vjust = -0.5),
              legend.position = "none", 
              axis.title.y = element_text(size =14, color = "black", vjust = 1),
              plot.title = element_text(size = 18, color = "black", vjust = 2.5),
              strip.text = element_text(face = "bold", size = rel(1))
        )  +
        facet_grid(farmer_type*season ~ dev_stage_code, scale = "free" , space ="free") + 
        ylim(0,1)  + ylab("Frequency") + xlab("Active ingredient")

#temp2 <- fungicide %>% filter(mix_type.y == 3)

#temp3 <- temp2 %>% group_by(id, devel_stage.y) %>% summarise(fre = n())

#ifpaste(temp2[, "active_ingr"], sep = ",")

#temp3
#%>% group_by(devel_stage.y) %>% 

# weed 


        

