library(ggplot2)

y.data <- YieldData %>% filter(id %in% p.key)  %>% select(country,season_id, main_id, id_w_harv,farmer_name, fresh_w, moisture) %>% mutate(y.at.14kg.ha = (fresh_w*(100 - moisture))/84*2000)

#th.data <- y.data %>% filter(country == "TH")

#write.csv(th.data, file = "~/Desktop/TH.yield.csv")

#y.data$season_id <- plyr::revalue(as.factor(y.data$season_id), c("1" = "2013.DS", "2" = "2013.WS", "3" = "2014.DS", "4" = "2014.WS", "5" = "2015.WS", "6" = "2015.WS"))

#y.data %>% filter(country == "TH")  %>% group_by(country, season_id, main_id) %>% summarise(m.y.14.ka.ha = mean(y.at.14kg.ha)) %>% 
        ggplot(aes(x = as.factor(season_id) , y = m.y.14.ka.ha, fill = as.factor(season_id))) + geom_boxplot() + ylab("Mean yield (kg/ha") + xlab("season#.year")
