#= do.R if for run all the script of the SKEP database
library(dplyr)
library(ggplot2)
library(reshape)
library(reshape2)
# source("collect_database.R")

#filepath <- file.path("C:", "Users", "sjaisong", "Google Drive", "surveySKEP1", "SKEP2database.RData" )
filepath <- file.path("~","Google Drive", "surveySKEP1", "SKEP2database.RData") # for Mac

load(filepath)

source("1.farm_info.R")

source("5.fert_data.R")

source("2.injury_profile.R")

# the final data is "survey" dataset     
survey <- left_join(Farmer_info, Fert_synthesis, by = c("id" = "id")) %>% left_join( Injury_profile, by = c("id" = "id_main"))

names(survey) <- c("id", "date", "country", "year", "season", "Fno", "village", "district", "province", "latitude", "longitude", "FN", "FA", "CES", "seed_rate",  "seed_age", "CEN_date", "HA_date", "var_name", "var_type", "pre_crop", "fallow_period", "soil_prop", "yield", "N", "P", "K", "SNL", "RT", "RH", "SS", "WH", "PM", "RB", "DP", "FS", "NB", "RGB", "SR", "RTH", "LF", "LM", "LS", "WM", "BLB", "BLS", "BS", "LB", "NBS", "RS", "BB", "GS", "RGS", "RTG", "YSD", "OSD", "STV", "DSCUM", "WSCUM", "WA", "WB")


# = set survey data of the SKEP2 , the production environment

survey$prod_env <- "na"
survey[survey$province == "ID-JB", ]$prod_env <- "West_Java"
survey[survey$province == "IN-OR", ]$prod_env <- "Odisha"
survey[survey$province == "IN-TN", ]$prod_env <- "Tamil_Nadu"
survey[survey$province == "TH-15", ]$prod_env <- "Central_Plain"
survey[survey$province == "TH-72", ]$prod_env <- "Central_Plain"
survey[survey$province == "VN-61", ]$prod_env <- "Red_river_delta"
survey[survey$season == "D", ]$season <- "dry_season"
survey[survey$season == "W", ]$season <- "wet_season"


survey <- as.data.frame(survey)
survey$farmer_type <- "na"

survey[survey$yield > 6000, ]$farmer_type <- "adopter"

survey[survey$yield >= 4000 & survey$yield <= 6000,]$farmer_type <- "majority"

survey[survey$yield < 4000,]$farmer_type <- "drifter"

survey[is.na(survey) ] <- 0
survey <- survey %>% group_by(prod_env, season, year) %>% mutate(no_farmer = n())
prod_env.name <- c("West_Java", "Odisha", "Tamil_Nadu", "Central_Plain", "Red_river_delta" )
farmer_type.name <- c("drifter", "majority", "adopter")
survey$farmer_type <- factor(survey$farmer_type, levels = c("adopter", "majority", "drifter"))

# collect the survey data in India 
survey_ods_majority <- survey %>% filter(prod_env == "Odisha")  %>% filter(farmer_type == "majority")
survey_ods_drifter <- survey %>% filter(prod_env == "Odisha")  %>% filter(farmer_type == "drifter")

survey_tmn_m <- survey %>% filter(prod_env == "Tamil_Nadu")

path <- file.path("~", "Google Drive", "4.SKEP2ProjectData", "Farm_survey")
#write.csv(as.data.frame(survey), file = paste(path, "/SKEP2_survey.csv", sep =""))

write.csv(as.data.frame(survey_ods), file = paste(path, "/SKEP2_survey_ods.csv", sep =""))
write.csv(as.data.frame(survey_tmn), file = paste(path, "/SKEP2_survey_tmn.csv", sep =""))

#survey <- read_csv(file = paste(path, "/SKEP2_survey.csv", sep =""))

