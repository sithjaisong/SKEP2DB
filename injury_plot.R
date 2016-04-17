

all.inj <- survey %>% select(prod_env, year, season, SNL, RT, RH, SS, WH, PM, RB, DP, FS, NB, RGB, SR, RTH, LF, LM, LS, WM, BLB, BLS, BS, LB, NBS, RS, BB, GS, RGS, RTG, YSD, OSD, STV) 

all.inj <- all.inj[, -(3 + nearZeroVar(all.inj[,-c(1, 2, 3)]))]

all.inj <- all.inj %>% melt(., id.vars = c("prod_env", "year","season"))

antinj <- c("SNL", "RT", "RH", "SS", "WH", "PM", "RB", "RTH", "LF", "WM")

all.inj$injtyp <- ifelse(all.inj$variable %in% antinj, "Animal injuries", "Disease")


all.inj[all.inj$value == 0,]$value <- NA


x.all.inj <- all.inj %>% transform(value = as.numeric(as.character(value))) %>% filter(prod_env == prod_env.name[5]) #%>% group_by(location, year, season, variable) %>% summarise(mv = mean(value))

ggplot(data = x.all.inj, aes(x = variable, y = value, fill = variable)) +
        geom_boxplot(outlier.shape = NA) +
        facet_grid(year*season ~ injtyp, scale = "free", space = "free") +
       ylim(c(0, 100)) +
        #scale_fill_brewer(palette= "Set3") + 
        labs(fill = " Injuries") +
        #  mytheme +
        xlab("Injuries") +
        ylab("Incidence (%)")
             
               
# +ggtitle("Injury profiles of Indonesiaa survey data from 2013 to 2014")