library(dplyr)
library(magrittr)
# delete sample data

p.key <- FieldData %>% filter(date > "2015-08-19") %>% .$id # the data start coming after Aug 19, 2015 when is the real data comming

vn.key <- FieldData %>% filter(date > "2015-08-19" & country == "VN") %>% .$id

# test in for the yield




       


