weedMang <- PestManagementData %>% filter(id %in% p.key) %>% select(id, apply.x, wm_method,  id_act_ingr.x, devel_stage.x, mix_type.x)

weedMang <- weedMang[!duplicated(weedMang), ]
