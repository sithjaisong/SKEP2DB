library(ggplot2)

y.data <- YieldData %>% select(country,season_id, main_id, id_w_harv,farmer_name, fresh_w, moisture) %>% mutate(y.at.14kg.ha = (fresh_w*(100 - moisture))/84*2000)


survey %>% ggplot(aes(x = prod_env, y = yield, fill = prod_env)) + geom_boxplot() + ylab("Mean yield (kg/ha)") + xlab("Production Environment")

ggsave(filename = "yield_data.png", path = "figs")
