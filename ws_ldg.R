# water status
ws <- InjuriesData %>% select(id_ci, id_main, visit, water_status)

#Lodgeing
ldg <- InjuriesData %>% select(id_ci, id_main, lodging)