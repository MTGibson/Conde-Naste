rm(list=ls())

library('dplyr')
library('tidyr')
library('rvest')
library('ggplot2')
library('tidyverse')
library('sjmisc')
library('Hmisc')

setwd("/Users/michaelgibson/Documents/GitHub/Conde-Naste")
conde_nast<-read.csv("conde_nast.csv")

conde_nast$white<-ifelse(conde_nast$race=="White"|conde_nast$race=="white"|conde_nast$race=="caucasian",1,0)
conde_nast$male<-ifelse(conde_nast$gender=="Man (cisgender)"|conde_nast$gender=="Man (transgender)",1,0)
conde_nast$straight<-ifelse(conde_nast$sexuality=="Straight",1,0)
conde_nast$cisgendered<-ifelse(conde_nast$gender=="Man (cisgender)"|conde_nast$gender=="Woman (cisgender)",1,0)

summary(conde_nast$white)
summary(conde_nast$male)
summary(conde_nast$straight)
summary(conde_nast$cisgendered)
summary(conde_nast$salary)

conde_nast$white_lb<-factor(conde_nast$white,levels = c(0,1), labels = c("Non-white","White"))
conde_nast$male_lb<-factor(conde_nast$male,levels = c(0,1), labels = c("Non-male","Male"))

conde_nast$yrs_role<-as.numeric(conde_nast$yrs_role)
conde_nast$yrs_exp<-ifelse(conde_nast$yrs_exp=="20 or more",20,conde_nast$yrs_exp)
label(conde_nast$yrs_exp) <- "Years of experience, topcoded at 20"

conde_nast$reports_ind<-ifelse(conde_nast$reports_ind=="NULL",0,conde_nast$reports_ind)
conde_nast$reports_dir<-ifelse(conde_nast$reports_dir=="NULL",0,conde_nast$reports_dir)
conde_nast$reports_any<-ifelse(conde_nast$reports_dir>0 | conde_nast$reports_ind>0,1,0)
conde_nast$reports_total<-conde_nast$reports_dir+conde_nast$reports_ind

summary(conde_nast$white)
summary(conde_nast$male)
summary(conde_nast$straight)
summary(conde_nast$cisgendered)
summary(conde_nast$salary)
summary(conde_nast$reports_ind)
summary(conde_nast$reports_dir)
summary(conde_nast$reports_any)
summary(conde_nast$reports_total)


c<-ggplot(data=conde_nast, aes(salary))
c1<-c+geom_density()
c1

c2<-c1+facet_grid(rows=vars(white_lb), cols=vars(male_lb))

c2

conde_nast$ln_salary<-ln(conde_nast$salary)

model_1 <- lm(salary ~ white + male + straight + cisgendered+ yrs_exp+yrs_role,data=conde_nast)
summary(model_1)


