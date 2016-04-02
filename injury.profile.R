season <- FieldData[,c(1,2)]

InjuriesData <- merge(InjuriesData, season, by.x = "id_main", by.y = "id")


vn.injury.profile <- vn.injury.data[!names(vn.injury.data) %in% c("id_ci", "water_status", "lodging", "crop_info", "devel_stage")] 

names(vn.injury.profile) <- tolower(make.names(names(vn.injury.profile)))

