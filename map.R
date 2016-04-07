########################Header################################################
# title         : Z-1map
# purpose       : plot the coordinates of survey fields;
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : 3-consistant.output.RData;
# outputs       : png;
# remarks 1     : ;
# remarks 2     : ;
#####################################################

library(ggplot2)
library(ggmap)

survey_site <- survey %>% select(id, country, year, province, latitude, longitude)
#---------------------

# loading the required packages

# getting the map
#ALL locations
map <- get_map(location = c(lon = 90, 
                            lat = 15), 
               zoom = 4,
               maptype =  "hybrid", 
               scale = 2)

# plotting the map with some points on it
ggmap(map) +
        geom_point(data = survey_site, 
                   aes(x = longitude, y = latitude, fill = "red", alpha = 0.8), 
                   size = 4, shape = 21
        ) + 
        guides(fill=FALSE, 
               alpha=FALSE, 
               size=FALSE
        ) +
        ylim(c(-10, 25)) + xlim(c(75, 110))

ggsave(filename = "SKEP2_survey_map.png",
       scale =2,
       path = "figs")


# Tami Nadu
IN_TN <- survey_site %>% filter(province == "IN-TN") %>% select(year, latitude, longitude)

map <- get_map(location = c(lon = mean(IN_TN$longitude), 
                            lat = mean(IN_TN$latitude)), 
               zoom = 10,
               maptype = "terrain", 
               scale = 2)

ggmap(map) +
        geom_point(data = IN_TN, 
                   aes(x = longitude, y = latitude, fill = year, alpha = 0.8), 
                   size = 4, shape = 21
        ) +  theme(legend.text = element_text(size = 12)) +
        guides(alpha=FALSE, 
               size=FALSE)

ggsave(filename = "IN_TN_survey_map.png",
       scale =2,
       path = "figs")

# ==

IN_OR <- survey_site %>% filter(province == "IN-OR") %>% select(year, latitude, longitude)

map <- get_map(location = c(lon = mean(IN_OR$longitude), 
                            lat = mean(IN_OR$latitude)), 
               zoom = 10,
               maptype = "terrain", 
               scale = 2)

ggmap(map) +
        geom_point(data = IN_OR, 
                   aes(x = longitude, y = latitude, fill = year, alpha = 0.8), 
                   size = 4, shape = 21
        ) +  theme(legend.text = element_text(size = 12)) +
        guides(alpha =FALSE, 
               size =FALSE) 

ggsave(filename = "IN_OR_survey_map.png",
       scale =2,
       path = "figs")

# = Indonesia

ID <- survey_site %>% filter(province == "ID-JB") %>% select(year, latitude, longitude)

map <- get_map(location = c(lon = 107.25, 
                            lat = -6.5), 
               zoom = 9,
               maptype = "terrain", 
               scale = 2)

ggmap(map)
ggmap(map) +
        geom_point(data = ID, 
                   aes(x = longitude, y = latitude, fill = year, alpha = 0.8), 
                   size = 4, shape = 21
        ) +  theme(legend.text = element_text(size = 12)) +
        guides(alpha =FALSE, 
               size =FALSE) 

ggsave(filename = "ID_survey_map.png",
       scale =2,
       path = "figs")

# = Thailand

TH <- survey_site %>% filter(province == "TH-72") %>% select(id,year, latitude, longitude)

map <- get_map(location = c(lon = mean(TH$longitude), 
                            lat = mean(TH$latitude)), 
               zoom = 9,
               maptype = "terrain", 
               scale = 2)


ggmap(map) +
        geom_point(data = TH, 
                   aes(x = longitude, y = latitude, fill = year, alpha = 0.8), 
                   size = 4, shape = 21
        ) +  theme(legend.text = element_text(size = 12)) +
        guides(alpha =FALSE, 
               size =FALSE) 

ggsave(filename = "TH_survey_map.png",
       scale =2,
       path = "figs")

#== VN

VN <- survey_site %>% filter(province == "VN-61") %>% select(id,year, latitude, longitude)

map <- get_map(location = c(lon = 106.25, 
                            lat = 20.75), 
               zoom = 10,
               maptype = "terrain", 
               scale = 2)

ggmap(map) +
        geom_point(data = VN, 
                   aes(x = longitude, y = latitude, fill = year, alpha = 0.8), 
                   size = 4, shape = 21
        ) +  theme(legend.text = element_text(size = 12)) +
        guides(alpha =FALSE, 
               size =FALSE) 
        

ggsave(filename = "VN_survey_map.png",
       scale =2,
       path = "figs")

