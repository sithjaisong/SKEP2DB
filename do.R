library(dplyr)
library(magrittr)
# delete sample data

p.key <- FieldData %>% filter(date > "2015-08-19") %>% .$id


# Yield Synthesis

y.synthesis <- YieldData %>% filter(id %in% p.key) %>% select(main_id, fresh_w, moisture) %>% mutate(y.at.14kg.ha = (fresh_w*(100 - moisture))/84*2000) %>% group_by(main_id) %>% summarise(act.yield = mean(y.at.14kg.ha))

# leaf and tiller injury Synthesis

#100: Fully mature

Inj <- InjuriesData %>% filter(id_main %in% p.key) 
    
names(Inj) <- c("id_ci", "id_main", "date", "visit", "WS", "LDG", "crop_info", "dev_stage", "sample", "nt",
               "np", "nl", "SNL", "RT", "DH", "SS", "WH", "PM", "RB", "RTH",
               "LF", "LM", "RH", "WM", "BLB", "BLS", "BS", "LB", "LS", "NBS",
               "RS", "DP", "FS", "NB", "SHB", "SHR", "BKN", "BD", "RGB", "SR")

Inj %>% select(id_ci, id_main, visit, dev_stage, sample, nt, np, nl, SNL, RT, DH, SS, WH, PM, RB, RTH, LF, LM, RH, WM, BLB, BLS, BS, LB, LS, NBS, RS, DP, FS, NB, SHB, SHR, BKN, BD, RGB, SR ) %>% mutate(DVS = ifelse(visit == 1, 40, 90), nlt = nl * nt) %>% group_by(DVS) %>% summarise(audpc                                                             

# Systemic injury Synthesis
