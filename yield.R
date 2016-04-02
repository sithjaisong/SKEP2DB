# Yield Synthesis

yield.synthesis <- YieldData %>% filter(id %in% p.key) %>% select(main_id, fresh_w, moisture) %>% mutate(y.at.14kg.ha = (fresh_w*(100 - moisture))/84*2000) %>% group_by(main_id) %>% summarise(act.yield = mean(y.at.14kg.ha))
