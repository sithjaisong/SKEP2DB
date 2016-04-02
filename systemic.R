# find the file main_id == 122

names(SystemicData) <- c("id_ci", "area", "BB", "GRS", "RGS", "RTG", "YSD", "OLS", "SRV")

SystemicData %>% group_by(id_ci) %>% summarise(m.BB = mean(BB),
                                               m.GRS = mean(GRS),
                                               m.RGS = mean(RGS),
                                               m.RTG = mean(RTG),
                                               m.YSD = mean(YSD),
                                               m.OLS = mean(OLS),
                                               m.SRV = mean(SRV))
