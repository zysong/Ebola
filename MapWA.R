lib<-c("sp", "rgdal", "classInt", "RColorBrewer", "ggplot2", "hexbin", "ggmap", "XML", "dplyr")
lapply(lib, require, character.only=T)
summary(gadm)
