library(ggplot2)

y.data <- YieldData %>% select(country,season_id, main_id, id_w_harv,farmer_name, fresh_w, moisture) %>% mutate(y.at.14kg.ha = (fresh_w*(100 - moisture))/84*2000)


survey %>% ggplot(aes(x = prod_env, y = yield, fill = prod_env)) + 
        geom_boxplot() + ylab("Mean yield (kg/ha)") + 
        xlab("Production Environment")


ggplot(yield%>% filter(location == "Indonesia" & year == "2013", season == "Dry Season"),
       aes(x= year, y= ymean, fill = location)) + 
        geom_boxplot() +
        facet_grid(. ~ season) +
        ylab("Yield (t/ha)") +
        scale_fill_brewer(palette = "Pastel1") +
        mytheme +
        theme(legend.position = "none") +
        ggtitle("Yields from Indonesia in 2014")
ggsave(filename = "yield_data.png", path = "figs")

ggsave("pic/indo.yield.png", height = 6, width = 12, dpi = 300)

ggplot(yield,
       aes(x= year, y= ymean, fill = location)) + 
        geom_boxplot() +
        facet_grid(. ~ season) +
        ylab("Yield (t/ha)") +
        xlab("Year") +
        labs(fill = "Location") +
        scale_fill_brewer(palette = "Set3") +
        mytheme +
        ggtitle("Yields from Survey data 2013 to 2014")
