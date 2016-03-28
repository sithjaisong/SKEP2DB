Inj <- Inj[!(Inj$nt == 0),]
temp <- Inj %>% select(id_main, visit, dev_stage, sample, nt, np, nl, 
                          SNL, RT, DH, SS, WH, PM, RB, RTH, LF, LM, RH, WM, BLB, BLS, BS, LB, LS, NBS, RS, DP, FS, NB, SHB, SHR, BKN, BRD, RGB, SR) %>% 
        mutate(DVS = ifelse(visit == 1, 40, 90), 
               nlt = nl*nt,
               SNL.percent = SNL/nt*100, # Percent of SNL damage on hill is number
               RT.percent = RT/nt*100,
               DH.percent = DH/nt*100, # Percent of Dead Heart in on hill is number tiller damaged by dead heart divide by number of tiller *100
               SS.percent = SS/nt*100, # Percent of Rat damage in one hill
               WH.percent = WH/nt*100, # Percent of GM or silver shoot
               PM.percent = PM/nt*100, # Percent of Rice Bug injuries in one hill
               RB.percent = RB/nt*100, # Percent of Whitehead in one hill
               DP.percent = DP/nt*100,# Percent of False smut in one hill
               FS.percent = FS/nt*100,
               NB.percent = NB/nt*100, # Percent of Neck Blast in one hill
               SHB.percent = SHB/nt*100, # Percent of Shealth Blight injuries in one hill
               SHR.percent = SHR/nt*100, # Percent of Shealth Rot in one hill
               BKN.percent = BKN/nt*100,
               BRD.percent = BRD/nt*100,
               RGB.percent = RGB/nt*100,
               SR.percent = SR/nt*100, # Percent of Stem rot on one hill
               RTH.percent = RTH/nlt*100, 
               LF.percent = LF/nlt*100, # Percent of Leaffolder in one hill
               LM.percent = LM/nlt*100,
               LS.percent = LS/nlt*100,
               RH.percent = RH/nlt*100,
               WM.percent = WM/nlt*100, # Percent of Whorl maggot injuries in one hill
               BLB.percent = BLB/nlt*100, # Percent of Bacterial leaf Blight in one hill
               BLS.percent = BLS/nlt*100, # Percent of Bacterial leaf streak in one hill
               BS.percent = BS/nlt*100, # Percent of Brown Spot in one hill
               LB.percent = LB/nlt*100, # Percent of leaf Blight in one hill
               NBS.percent = NBS/nlt*100, # Percent of Narrow brown spot in one hill
               RS.percent = RS/nlt*100 # Percent of Red stripe in one hill
        ) %>%
        group_by(id_main, visit, DVS) %>%
        summarise(m.SNL = mean(SNL.percent),
                  m.RT = mean(RT.percent),
                  m.DH = mean(DH.percent),
                  m.SS = mean(SS.percent),
                  m.WH = mean(WH.percent), 
                  m.PM = mean(PM.percent),
                  m.RB = mean(RB.percent),
                  m.DP = mean(DP.percent), 
                  m.FS = mean(FS.percent), 
                  m.NB = mean(NB.percent),
                  m.SHB = mean(SHB.percent), 
                  m.SHR = mean(SHR.percent), 
                  m.BKN = mean(BKN.percent),
                  m.BRD = mean(BRD.percent),
                  m.RGB = mean(RGB.percent),
                  m.SR = mean(SR.percent),
                  m.RTH = mean(RTH.percent),
                  m.LF = mean(LF.percent),
                  m.LM = mean(LM.percent),
                  m.LS = mean(LS.percent),
                  m.WM = mean(WM.percent),
                  m.BLB = mean(BLB.percent),
                  m.BLS = mean(BLS.percent),
                  m.BS = mean(BS.percent),
                  m.LB = mean(LB.percent),
                  m.NBS = mean(NBS.percent),
                  m.RS = mean(RS.percent))
                  
 temp <- temp  %>% as.data.frame()
 temp$id_main <- as.factor(temp$id_main)
 temp$DVS <- as.numeric(temp$DVS)
 aggregate()
 temp <- temp %>% group_by(id_main) %>% summarise(LF = audpc(m.LF, DVS))

temp <- as.data.frame(temp[complete.cases(temp),])
temp %>% summarise(LF = audpc(m.LF, DVS))            
                
                
                
                max.SNL = max(m.SNL),
                  max.RT = max(m.RT),
                  max.RH = max(m.DH),
                  max.SS = max(m.SS),
                  max.WH = max(m.WH),
                  max.PM = max(m.PM),
                  max.RB = max(m.RB),
                  max.DP = max(m.DP),
                  max.FS = max(m.FS),
                  max.NB = max(m.NB),
                  max.RGB = max(m.RGB),
                  max.SR = max(m.SR),
                  audpc.RTH = audpc(m.RTH, DVS),
                  audpc.LF = audpc(m.LF, DVS),
                  audpc.LM = audpc(m.LM, DVS),
                  audpc.LS = audpc(m.LS, DVS),
                  audpc.WM = audpc(m.WM, DVS),
                  audpc.BLB = audpc(m.BLB, DVS),
                  audpc.BLS = audpc(m.BLS, DVS),
                  audpc.BS = audpc(m.BS, DVS),
                  audpc.LB = audpc(m.LB, DVS),
                  audpc.NBS = audpc(m.NBS, DVS),
                  audpc.RS = audpc(m.RS, DVS)
        )
