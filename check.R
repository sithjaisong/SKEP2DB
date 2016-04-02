khoi <- FieldData %>% filter(user_id == 38)

FieldData$status_panicle <- NULL

 FieldData[!complete.cases(FieldData),]

InjuriesData[!complete.cases(InjuriesData),]

FieldData %>% filter(id_cem == "NA")


Incom_inju <- InjuriesData[(InjuriesData$nt == 0),] %>% filter(sample < 11 ) %>% select(id_main, visit)
Incom_inju <- Incom_inju[!duplicated(Incom_inju), ]

# select the one field for test.


# check the data whather complete or not.

incomplete_injury <- Injury.synthesis[!complete.cases(Injury.synthesis),]
incomplete_injury<- incomplete_injury %>% filter(id_main != "NA")

field_incomplete <- left_join(Incom_inju, FieldData,  by = c("id_main" = "id"))

