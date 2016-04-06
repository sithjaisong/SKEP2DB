library(dplyr)
library(magrittr)
# delete sample data

source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\collect_database.R")

source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\1.farm_info.R")

source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\5.fert_data.R")

source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\2.injury_profile.R")

Farmer_info
# the final data is "survey" dataset     
survey <- left_join(Farmer_info, Fert_synthesis, by = c("id" = "id")) %>% left_join( Injury_profile, by = c("id" = "id_main"))


head(survey)


names(survey) <- c("Fno", "date", "year", "season", "FNo", "village", "district", "PE", "lat", "lon", "FN", "FA", "CES", "seed_age", )
