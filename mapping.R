library(sp)
library(rgdal)
library(rgeos)
library(maptools)
library(raster)

gin_adm2<-readOGR("MapData/GIN_adm", "GIN_adm2")
summary(gin_adm2)
spplot(gin_adm2, "NAME_2")

lbr_adm1<-readOGR("MapData/LBR_adm", "LBR_adm1")
summary(lbr_adm1)
spplot(lbr_adm1, "NAME_1")

sle_adm2<-readOGR("MapData/SLE_adm", "SLE_adm2")
summary(sle_adm2)
spplot(sle_adm2, "NAME_2")

dist_names<-c(as.character(gin_adm2$NAME_2), as.character(lbr_adm1$NAME_1), 
              as.character(sle_adm2$NAME_2))
dist_names<-gsub("É", "E", toupper(dist_names)) #Convert to English names
dist_names[!dist_names %in% sum.byDistrict$district] #Find the mismatched names
dist_names[!dist_names %in% sum.byDistrict$district]<-
  c("CONAKRY", "MANDIANA", "N'ZEREKORE", "YOMOU", "RIVERCESS", "GBARPOLU", "GRAND BASSA", 
    "GRAND GEDEH", "GRAND KRU", "WESTERN AREA RURAL", "WESTERN AREA URBAN") 
#Correct district names

#Union district maps of the three countries
WA_adm2<-union(union(gin_adm2, lbr_adm1), sle_adm2)
WA_adm2@data<-data.frame(dist_names)
summary(WA_adm2)
spplot(WA_adm2)

#Join the polygons and case report
sum.byDistrict<-read.csv("SumByDist.csv")
WA_adm_cases<-merge(WA_adm2, sum.byDistrict, by.x = "dist_names", by.y = "district")
summary(WA_adm_cases)
spplot(WA_adm_cases, "sum.conf", col = heat.colors(2))
spplot(WA_adm_cases, "sum.tot", col = heat.colors(2))
