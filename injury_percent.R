
        result <- vn.injury.profile %>%
                mutate(nlh = nl * nt, 
                       # Number of leave = number of tiller * number of leave per tiller
                       # tiller injuries
                       SNL.percent = snail/nt*100, # Percent of SNL damage on hill is number
                       RT.percent = rat.injury/nt*100,
                       DH.percent = deadheart/nt*100, # Percent of Dead Heart in on hill is number tiller damaged by dead heart divide by number of tiller *100
                       SS.percent = silvershoot/nt*100, # Percent of Rat damage in one hill
                       WH.percent = whitehead/nt*100, # Percent of GM or silver shoot
                       PM.percent = panicle.mite/nt*100, # Percent of Rice Bug injuries in one hill
                       RB.percent = rice.bug.injury/nt*100, # Percent of Whitehead in one hill
                       DP.percent = dirty.panicle/nt*100,# Percent of False smut in one hill
                       FS.percent = false.smut/nt*100,
                       NB.percent = neck.blast/nt*100, # Percent of Neck Blast in one hill
                       SHB.percent = sheath.blight/nt*100, # Percent of Shealth Blight injuries in one hill
                       SHR.percent = sheath.rot/nt*100, # Percent of Shealth Rot in one hill
                       BKN.percent = bakanae/nt*100,
                       BRD.percent = bird.injury/nt*100,
                       RGB.percent = rice.grain.bug.injury/nt*100,
                       SR.percent = stem.rot/nt*100, # Percent of Stem rot on one hill
                       # leave injuries
                       RTH.percent = rice.thrip/nlh*100, 
                       LF.percent = leaffolder/nlh*100, # Percent of Leaffolder in one hill
                       WM.percent = whorl.maggot/nlh*100, # Percent of Whorl maggot injuries in one hill
                       BLB.percent = bacterial.leaf.blight/nlh*100, # Percent of Bacterial leaf Blight in one hill
                       BLS.percent = bacterial.leaf.streak/nlh*100, # Percent of Bacterial leaf streak in one hill
                       BS.percent = brown.spot/nlh*100, # Percent of Brown Spot in one hill
                       LB.percent = leaf.blast/nlh*100, # Percent of leaf Blight in one hill
                       NBS.percent = narrow.brown.spot/nlh*100, # Percent of Narrow brown spot in one hill
                       RS.percent = red.stripe/nlh*100 # Percent of Red stripe in one hill
                ) %>%
                group_by(season_id, id_main, visit) %>%
                summarise(m.SNL = mean(SNL.percent),
                        m.RT = mean(RT.percent),
                        m.DH = mean(DH.percent),
                        m.SS = mean(SS.percent),
                        m.WH = mean(WH.percent), # Percent of Whitehead in one hill
                        m.PM = mean(PM.percent),
                        m.RB = mean(RB.percent),
                        m.DP = mean(DP.percent), # Percent of Dirty Panicle in one hill
                        m.FS = mean(FS.percent), # Percent of False smut in one hill
                        m.NB = mean(NB.percent), # Percent of Neck Blast in one hill
                        m.SHB = mean(SHB.percent), # Percent of Shealth Blight injuries in one hill
                        m.SHR = mean(SHR.percent), # Percent of Shealth Rot in one hill
                        m.BKN = mean(BKN.percent),
                        m.BRD = mean(BRD.percent),
                        m.RGB = mean(RGB.percent),
                        m.SR = mean(SR.percent),
                        m.RTH = mean(RTH.percent),
                        m.LF = mean(LF.percent),
                        m.WM = mean(WM.percent),
                        m.BLB = mean(BLB.percent),
                        m.BLS = mean(BLS.percent),
                        m.BS = mean(BS.percent),
                        m.LB = mean(LB.percent),
                        m.NBS = mean(NBS.percent),
                        m.RS = mean(RS.percent)
                )
#                 ) %>%
#                 group_by(index, Country, Year, Season, Fieldno) %>% 
#                 summarise(SNL.max = max(m.SNL),
#                           RT.max = max(m.RT),
#                           DH.max = max(m.DH),
#                           SS.max = max(m.SS),
#                           WH.max = max(m.WH),
#                           PM.max = max(m.PM),
#                           RB.max = max(RB.max),
#                           DP.max = max(m.DP),
#                           FS.max = max(m.FS),
#                           NB.max = max(m.NB),
#                           SHB.max = max(m.SHB),
#                           SHR.max = max(m.SHR),
#                           BKN.max = max(m.BKN),
#                           BRD.max = max(m.BRD),
#                           RGB.max = max(m.RBG),
#                           SR.max = max(m.SR),
#                           
#                 )
#         return(result)
# }

        result <- result %>% transform(
                season_id = as.factor(season_id),
                id_main = as.factor(id_main),
                visit = as.factor(visit)
                )

        long.injury.profiles <- melt(result)  
        varname <- levels(long.injury.profiles$variable)
        
        boxplot <- list()
        
        for (i in 1:length(varname)) {
                boxplot[[i]] <- long.injury.profiles %>% filter(variable == varname[i]) %>% ggplot(aes(x = season_id, y = value, fill = visit, color = visit)) +
                        geom_boxplot() + 
                        theme(legend.position = "none",
                              panel.background = element_blank(),
                              axis.line = element_line(size = 0.5),
                              axis.title.x = element_blank()) +
                        scale_fill_manual(values = c("1" = "steelblue1", "2" = "indianred1")) + 
                        scale_color_manual(values = c("1" = "steelblue4", "2" = "indianred4")) +
                        ylab("percent") +
                        ggtitle(paste(varname[i]))
        }
        
        all.dataset.boxplot <- marrangeGrob(boxplot, nrow = 2, ncol = 3)
        