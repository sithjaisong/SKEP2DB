library(reshape)
library(reshape2)

survey$farmer_type <- "na"
survey[survey$yield > 6000,]$farmer_type <- "adopter"
survey[survey$yield >= 4000 & survey$yield <= 6000,]$farmer_type <- "majority"
survey[survey$yield < 4000,]$farmer_type <- "drifter"



survey %>% group_by(prod_env, farmer_type) %>% summarise(No = n()) %>% ggplot(aes(x = farmer_type, y = No, fill = farmer_type), color = "black") + 
        geom_bar(width = 1, alpha = 0.8, stat = "identity") + 
        geom_text(aes(label = No), size = rel(4))+ scale_y_continuous(breaks = 0:5)  + coord_polar() +
        labs(x = "", y = "") + 
        theme(axis.text.y = element_blank(), axis.ticks = element_blank(), axis.text.x = element_text(size = rel(1.5)), strip.text.x = element_text(size = 20)) +
        facet_wrap( ~ prod_env)
ggsave(file = "piechart.png")


