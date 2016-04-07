

all.inj <- survey %>% select(prod_env, year, season, SNL, RT, RH, SS, WH, PM, RB, DP, FS, NB, RGB, SR, RTH, LF, LM, LS, WM, BLB, BLS, BS, LB, NBS, RS, BB, GS, RGS, RTG, YSD, OSD, STV) 


all.inj$injtyp <- ifelse(all.inj$variable %in% antinj, "Animal injuries", "Disease")


%>% melt(., id.vars = c("prod_env", "year","season"))

all.inj[all.inj$value == 0,]$value <- NA

antinj <- c("SNL", "RT", "RH", "SS", "WH", "PM", "RB", "RTH", "LF", "WM")
all.inj$injtyp <- ifelse(all.inj$variable %in% antinj, "Animal injuries", "Disease")


x.all.inj <- all.inj %>% filter(prod_env == "Red_river_delta") #%>% group_by(location, year, season, variable) %>% summarise(mv = mean(value))

ggplot(data = x.all.inj, aes(x = variable, y = value, fill = variable)) +
        geom_boxplot(outlier.shape = NA) +
        facet_grid(year*season ~ ., scale = "free", space = "free") +
        ylim(c(0, 100)) +
        #scale_fill_brewer(palette= "Set3") + 
        labs( fill = " Injuries") +
        #  mytheme +
        xlab("Injuries") +
        ylab("Incidence (%)")
             
              +
        ggtitle("Injury profiles of Indonesiaa survey data from 2013 to 2014")