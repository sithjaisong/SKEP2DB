
precrop_data <- survey %>% select(prod_env, pre_crop) %>% group_by(prod_env) %>% mutate(Fno = n()) %>% group_by(prod_env, pre_crop) %>% mutate(no_precrop = n(), percent_precrop = no_precrop/Fno*100) 

precrop_data <- precrop_data[!duplicated(precrop_data), ]

precrop_data %>% ggplot(aes(x = prod_env, y = percent_precrop, fill = pre_crop)) + geom_bar(stat = "identity")  + xlab("Production environemnt") + ylab("Previous crop (%)") + scale_fill_discrete( name = "Previous crop") + theme(axis.title = element_text(size = rel(1.5)), axis.text = element_text(size = rel(1.2)))

