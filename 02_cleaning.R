rm(list=ls())

library('dplyr')
library('tidyr')
library('rvest')
library('ggplot2')
library('tidyverse')
library('sjmisc')


setwd("/Users/michaelgibson/Documents/GitHub/Conde-Naste")
raw<-read.csv("raw_cn.csv")


raw$male<-ifelse(raw$gender=="Man (cisgender)"|raw$gender=="Man (transgender)",1,0)
raw$straight<-ifelse(raw$sex_orien=="Straight",1,0)
raw$cisgendered<-ifelse(raw$gender=="Man (cisgender)"|raw$gender=="Woman (cisgender)",1,0)

summary(raw$male)
summary(raw$straight)
summary(raw$cisgendered)

