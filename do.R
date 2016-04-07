

source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\collect_database.R")

source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\1.farm_info.R")

source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\5.fert_data.R")

source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\2.injury_profile.R")

# the final data is "survey" dataset     
survey <- left_join(Farmer_info, Fert_synthesis, by = c("id" = "id")) %>% left_join( Injury_profile, by = c("id" = "id_main"))

names(survey) <- c("id", "date", "country", "year", "season", "Fno", "village", "district", "province", "latitude", "longitude", "FN", "FA", "CES", "seed_rate",  "seed_age", "CEN_date", "HA_date", "var_name", "var_type", "pre_crop", "fallow_period", "soil_prop", "yield", "N", "P", "K", "SNL", "RT", "RH", "SS", "WH", "PM", "RB", "DP", "FS", "NB", "RGB", "SR", "RTH", "LF", "LM", "LS", "WM", "BLB", "BLS", "BS", "LB", "NBS", "RS", "BB", "GS", "RGS", "RTG", "YSD", "OSD", "STV", "DSCUM", "WSCUM", "WA", "WB")


# = set the production environment

survey$prod_env <- "na"
survey[survey$province == "ID-JB", ]$prod_env <- "West_Java"
survey[survey$province == "IN-OR", ]$prod_env <- "Ordisha"
survey[survey$province == "IN-TN", ]$prod_env <- "Tamil_Nadu"
survey[survey$province == "TH-15", ]$prod_env <- "Central_Plain"
survey[survey$province == "TH-72", ]$prod_env <- "Central_Plain"
survey[survey$province == "VN-61", ]$prod_env <- "Red_river_delta"

survey[survey$season == "D", ]$season <- "dry_season"
survey[survey$season == "W", ]$season <- "wet_season"


