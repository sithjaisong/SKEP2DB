#=======Load libraries=======
library(XLConnect)
library(plyr)
library(dplyr)
library(reshape)
library(reshape2)
#========End of loading the llibraries=================

options(stringAsFactors = FALSE)
options(java.parameters = "-Xmx1024m")


file <- list.files(path = paste("E:/Google Drive/Data/SYT-SKEP/Survey/", sep = ""), pattern = "xlsx$", full.names = TRUE) # For Window # load excel file from the shared folder
file
# count the number of file, there are 13 excel files
#===========start with fertilizer ============
fertilizer.list <- list()

for(i in 1: length(file)){
        filepath <- file[i]
        workbook <- loadWorkbook(filepath)
        temp <- readWorksheet(workbook, sheet = 2,
                                   forceConversion = TRUE)
        #col_names <- names(pesticide)
        fer.vars <- names(temp) %in% c("location", "year", "season", "fno", "comN", "comP", "comK")
        fertilizer.list[[i]] <- temp[fer.vars]
}

all.fertilizer <- do.call("bind_rows", fertilizer.list)
########## compute fertilizer ############

com.fer <- all.fertilizer %>% 
        group_by(location, year, season, fno) %>%
        summarise(sum.N = sum(comN),
                  sum.P = sum(comP),
                  sum.K = sum(comK)
                  )

######### finish fertilizer profiles ######

######## start variett profile
variety.list <- list()

for(i in 1: length(file)){
        filepath <- file[i]
        workbook <- loadWorkbook(filepath)
        temp <- readWorksheet(workbook, sheet = "practice",
                              forceConversion = TRUE)
        names(temp) <- tolower(names(temp))
        vartype.vars <- names(temp) %in% c("location", "year", "season", "fno", "vartype")
        variety.list[[i]] <- temp[vartype.vars]
}

all.varieties <- do.call("bind_rows", variety.list)
all.varieties <- all.varieties[complete.cases(all.varieties),]

#pesticide.list <- list()


# mainly use dplyr function
names(all.inj)

all.inj$Fno <- NULL
all.inj$fieldno <- NULL
names(all.inj) <- tolower(names(all.inj))

ldg.shb <- all.inj %>% 
        select(location, year, season, fno, visit, ldg, nt, np, nlt, shb) %>%
        mutate(Nlh = nt*nlt,
               shb.percent = shb/nt*100) %>%
        group_by(season, year , location, year, season, fno, visit) %>%
        summarise(mean.ldg = mean(ldg),
                mean.ShB = mean(shb.percent))
            
#===== corrected the varibales types =====#
str(all.varieties)
str(com.fer)


all.varieties <- all.varieties %>%
        transform(year = as.factor(year),
                  location = as.factor(location),
                  season = as.factor(season),
                  fno = as.factor(fno),
                  vartype = as.factor(vartype))

str(com.fer)

com.fer <- com.fer %>%
        transform(year = as.factor(year),
                  location = as.factor(location),
                  season = as.factor(season),
                  fno = as.factor(fno)
                  )
str(ldg.shb)

ldg.shb <-ldg.shb%>%
        transform(year = as.factor(year),
                  location = as.factor(location),
                  season = as.factor(season),
                  fno = as.factor(fno),
                  vist = as.factor(visit)
        )
#levels(ldg.shb$location)
levels(ldg.shb$location)[levels(ldg.shb$location) == "idn"] <- "IDN"
levels(ldg.shb$location)[levels(ldg.shb$location) == "ods"] <- "ODS"
levels(ldg.shb$location)[levels(ldg.shb$location) == "tha"] <- "THA"
levels(ldg.shb$location)[levels(ldg.shb$location) == "tmn"] <- "TMN"
levels(ldg.shb$location)[levels(ldg.shb$location) == "vnm"] <- "VNM"

levels(ldg.shb$season)[levels(ldg.shb$season) == "ds"] <- "DS"
levels(ldg.shb$season)[levels(ldg.shb$season) == "ws"] <- "WS"


ldg.shb$vist <- NULL

test <- merge(all.varieties, com.fer, by = c("location","year","season", "fno"))
all <- merge(test, ldg.shb, by = c("location","year","season", "fno"))

write.csv(file = "ldg_shb.csv", all)
levels(ldg.shb$location)

levels(ldg.shb$location)[levels(ldg.shb$location) == "idn"] <- "IDN"
levels(ldg.shb$location)[levels(ldg.shb$location) == "vnm"] <- "VNM"




        
