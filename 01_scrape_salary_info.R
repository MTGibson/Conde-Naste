rm(list=ls())

library('dplyr')
library('tidyr')
library('rvest')
library('ggplot2')
library('tidyverse')
library("XML")
library("googlesheets4")

setwd("/Users/michaelgibson/Documents/GitHub/Conde-Naste")

#gs4_browse("https://docs.google.com/spreadsheets/u/1/d/1YqdJCJ3LmtVIzxsgOj-YhE8fGBQ3zhuEkWp-_og2HEE/htmlview?pru=AAABcsoMglg*NgqVwN1JSbezwnZ9b6PYNg")
cnast<-range_read("https://docs.google.com/spreadsheets/u/1/d/1YqdJCJ3LmtVIzxsgOj-YhE8fGBQ3zhuEkWp-_og2HEE/htmlview?pru=AAABcsoMglg*NgqVwN1JSbezwnZ9b6PYNg")	

rowtitles<- cnast[c(2), ]
raw<- cnast[-c(1,2), ]


names(raw)[which(names(raw) == "HERE IS A GOOGLE FORM TO ADD YOUR INFO: https://forms.gle/i6QLjLwV3fR9XCkt9")] <- "title"
names(raw)[which(names(raw) == "...2")] <- "salary"
names(raw)[which(names(raw) == "...3")] <- "race"
names(raw)[which(names(raw) == "...4")] <- "gender"
names(raw)[which(names(raw) == "...5")] <- "sexuality"
names(raw)[which(names(raw) == "...6")] <- "employ_status"
names(raw)[which(names(raw) == "...7")] <- "yrs_role"
names(raw)[which(names(raw) == "...8")] <- "yrs_exp"
names(raw)[which(names(raw) == "...9")] <- "reports_ind"
names(raw)[which(names(raw) == "...10")] <- "reports_dir"
names(raw)[which(names(raw) == "...11")] <- "additonal_comp"
names(raw)[which(names(raw) == "...12")] <- "notes"


conde_nast<-as.data.frame(raw)
conde_nast<- conde_nast[,-c(13)]

conde_nast <- apply(conde_nast,2,as.character)


write.csv(conde_nast,'conde_nast.csv') 
