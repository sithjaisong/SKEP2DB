library(dplyr)
library(magrittr)
# delete sample data

        
FieldData %>% filter(date > "2015-08-19")


clean_FieldData <- FieldData %>% filter(date > "2015-08-19")%>% filter(id_main.x != "NA") %>% filter(field_num != "test")

p.key  <- clean_FieldData  %>% .$id


# yield
source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\yield.R")

# Injury
source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\injury.R")

# Systemic
source("C:\\Users\\sjaisong\\Documents\\GitHub\\SKEP2DB\\systemic.R")