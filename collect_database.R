library(SYT.SKEP)
# First login

SKEPdb <- loginSKEP("sjaisong", "MovingProton1")

#### Form1 Data ####
# 2. get Field Data

FieldData <- getFielddata(SKEPdb)

# 3. Fertilizer data

FertilizerData <- getFertilizerData(SKEPdb)

# 4. Pest Management Data

PestManagementData <- getPestManagementData(SKEPdb)

# 5. Yield Data

YieldData <- getYieldData(SKEPdb)

#### Form 2 Data #####

# 5. Injuries Datas

InjuriesData <- getInjuriesData(SKEPdb)

# 6. Systemic Data

SystemicData <- getSystemicData(SKEPdb)

# 8. Weed data

WeedData <- getWeedData(SKEPdb)


# table 1
active_ingr <- tbl(SKEPdb, "active_ingr")
# table 2
cem_type <- tbl(SKEPdb, "cem_type")
# table 3
crop_estab_type <- tbl(SKEPdb, "crop_estab_met")
# table 4
rice_var_type <- tbl(SKEPdb, "rice_var_type")
# table 5 
season_type <- tbl(SKEPdb, "seasons")
# table 6
soil_prop_type <- tbl(SKEPdb, "soil_prob_type")
# table 7
water_status_type <- tbl(SKEPdb, "water_status")
# table 8
weed_list <- tbl(SKEPdb, "weed_list")
# table 9
dev_stage <- tbl(SKEPdb, "devel_stage")
# table 10
weed_mgnt_type <- tbl(SKEPdb, "weed_mgnt_type")
# table 11
weed_type <- tbl(SKEPdb, "weed_type")



# 9.Save in Rdata
filepath <- file.path("C:", "Users", "sjaisong", "Google Drive", "surveySKEP1", "SKEP2database.RData" )
filepath

save(FieldData, FertilizerData, PestManagementData, YieldData, InjuriesData, SystemicData, WeedData,
     active_ingr, cem_type, crop_estab_type, rice_var_type, season_type, soil_prop_type, water_status_type, weed_list, dev_stage, weed_mgnt_type, weed_type,
     file = filepath)

