library(ggplot2)

y.data <- YieldData %>% select(country,season_id, main_id, id_w_harv,farmer_name, fresh_w, moisture) %>% mutate(y.at.14kg.ha = (fresh_w*(100 - moisture))/84*2000)


survey %>%  filter(prod_env == "Central_Plain") %>% ggplot(aes(x = farmer_type, y = yield, fill = prod_env)) + geom_boxplot() + theme(panel.background = element_rect(fill = "white"), panel.border = element_rect(color = "grey85", fill = NA), panel.grid.major = element_line(color = "grey85", linetype = "dashed"), axis.title = element_text(size = rel(2)), axis.text = element_text(size = rel(1.5))) + ylab("rice field are (ha)") + xlab("Production environment") + scale_fill_discrete(name = "Production env") + ylab("Mean yield (kg/ha)") + xlab("Production Environment") + stat_summary(fun.y = mean, color="black", geom="text", show_guide = FALSE,  vjust=-0.5, aes( label=round(..y.., digits=1))) + facet_grid(~ year*season)




c("West_Java", "Odisha", "Tamil_Nadu", "Central_Plain", "Red_river_delta" )
