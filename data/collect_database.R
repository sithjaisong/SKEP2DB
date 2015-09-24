# First login

SKEPdb <- loginSKEP("sjaisong", "MovingProton793")

#### Form1 Data ####
# 2. get Field Data

FieldData <- getFielddata(SKEPdb)

# 3. Fertilizer data

FertilizerrData <- getFertilizerData(SKEPdb)

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

# 9.Save in Rdata

save(FieldData, )

