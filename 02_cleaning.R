rm(list=ls())

library('dplyr')
library('tidyr')
library('rvest')
library('ggplot2')
library('tidyverse')
library('sjmisc')
library('Hmisc')
library('bbplot')

setwd("/Users/michaelgibson/Documents/GitHub/Conde-Naste")
conde_nast<-read.csv("conde_nast.csv")

conde_nast$white<-ifelse(conde_nast$race=="White"|conde_nast$race=="white"|conde_nast$race=="caucasian",1,0)
conde_nast$male<-ifelse(conde_nast$gender=="Man (cisgender)"|conde_nast$gender=="Man (transgender)",1,0)
conde_nast$straight<-ifelse(conde_nast$sexuality=="Straight",1,0)
conde_nast$cisgendered<-ifelse(conde_nast$gender=="Man (cisgender)"|conde_nast$gender=="Woman (cisgender)",1,0)
conde_nast$fulltime<-ifelse(conde_nast$employ_status=="Full-time",1,0)



conde_nast$white_lb<-factor(conde_nast$white,levels = c(0,1), labels = c("Non-white","White"))
conde_nast$male_lb<-factor(conde_nast$male,levels = c(0,1), labels = c("Non-male","Male"))

conde_nast$yrs_role<-as.numeric(conde_nast$yrs_role)
conde_nast$yrs_exp<-ifelse(conde_nast$yrs_exp=="20 or more",20,conde_nast$yrs_exp)
label(conde_nast$yrs_exp) <- "Years of experience, topcoded at 20"

conde_nast$reports_ind<-ifelse(conde_nast$reports_ind=="NULL",0,conde_nast$reports_ind)
conde_nast$reports_dir<-ifelse(conde_nast$reports_dir=="NULL",0,conde_nast$reports_dir)
conde_nast$reports_any<-ifelse(conde_nast$reports_dir>0 | conde_nast$reports_ind>0,1,0)
conde_nast$reports_total<-conde_nast$reports_dir+conde_nast$reports_ind

conde_nast$additonal_comp<-as.character(conde_nast$additonal_comp)
conde_nast$additonal_comp<-ifelse(conde_nast$additonal_comp=="none"|
                                    conde_nast$additonal_comp=="None"|
                                    conde_nast$additonal_comp=="N/A"|
                                    conde_nast$additonal_comp=="0"|
                                    conde_nast$additonal_comp=="n/a",
                                    NA,conde_nast$additonal_comp)

conde_nast$add_comp_any<-ifelse(is.na(conde_nast$additonal_comp),0,1)


summary(conde_nast$white)
summary(conde_nast$male)
summary(conde_nast$straight)
summary(conde_nast$cisgendered)
summary(conde_nast$salary)
summary(conde_nast$reports_ind)
summary(conde_nast$reports_dir)
summary(conde_nast$reports_any)
summary(conde_nast$reports_total)
summary(conde_nast$fulltime)

conde_nast$salary_thou<-conde_nast$salary/1000

c<-ggplot(data=conde_nast, aes(salary_thou))
c1<-c+geom_density()
c1

c2<-c1+facet_grid(rows=vars(white_lb), cols=vars(male_lb))
c3<-c2+bbc_style()+
  labs(title="Conde Nast Salaries")+
  theme(axis.title = element_text(size = 12))+
  labs(x = "Salary, in 1,000 USDs", 
         y = "Density")+
  theme(
    axis.ticks.x = element_line(colour = "#333333"), 
    axis.ticks.length =  unit(0.26, "cm"))


c3

finalise_plot(plot_name=c3, source_name = "Conde Nast Salary Survey", save_filepath="/Users/michaelgibson/Documents/GitHub/Conde-Naste/salary.png", width_pixels = 640,
              height_pixels = 450)


model_1 <- lm(salary_thou ~ white + male + straight + cisgendered+ yrs_exp+yrs_role,data=conde_nast)
summary(model_1)


model_2 <- lm(salary_thou ~ white + male + straight + cisgendered+ yrs_exp+yrs_role+reports_total,data=conde_nast)
summary(model_2)

summary(subset(conde_nast, conde_nast$white==1)$reports_total)
summary(subset(conde_nast, conde_nast$white==0)$reports_total)
summary(subset(conde_nast, conde_nast$male==1)$reports_total)
summary(subset(conde_nast, conde_nast$male==0)$reports_total)
summary(subset(conde_nast, conde_nast$straight==1)$reports_total)
summary(subset(conde_nast, conde_nast$straight==0)$reports_total)
summary(subset(conde_nast, conde_nast$cisgendered==1)$reports_total)
summary(subset(conde_nast, conde_nast$cisgendered==0)$reports_total)

summary(subset(conde_nast, conde_nast$white==1)$reports_any)
summary(subset(conde_nast, conde_nast$white==0)$reports_any)
summary(subset(conde_nast, conde_nast$male==1)$reports_any)
summary(subset(conde_nast, conde_nast$male==0)$reports_any)
summary(subset(conde_nast, conde_nast$straight==1)$reports_any)
summary(subset(conde_nast, conde_nast$straight==0)$reports_any)
summary(subset(conde_nast, conde_nast$cisgendered==1)$reports_any)
summary(subset(conde_nast, conde_nast$cisgendered==0)$reports_any)

summary(subset(conde_nast, conde_nast$white==1)$reports_any)
summary(subset(conde_nast, conde_nast$white==0)$reports_any)
summary(subset(conde_nast, conde_nast$male==1)$reports_any)
summary(subset(conde_nast, conde_nast$male==0)$reports_any)
summary(subset(conde_nast, conde_nast$straight==1)$reports_any)
summary(subset(conde_nast, conde_nast$straight==0)$reports_any)
summary(subset(conde_nast, conde_nast$cisgendered==1)$reports_any)
summary(subset(conde_nast, conde_nast$cisgendered==0)$reports_any)

summary(subset(conde_nast, conde_nast$white==1)$add_comp_any)
summary(subset(conde_nast, conde_nast$white==0)$add_comp_any)
summary(subset(conde_nast, conde_nast$male==1)$add_comp_any)
summary(subset(conde_nast, conde_nast$male==0)$add_comp_any)
summary(subset(conde_nast, conde_nast$straight==1)$add_comp_any)
summary(subset(conde_nast, conde_nast$straight==0)$add_comp_any)
summary(subset(conde_nast, conde_nast$cisgendered==1)$add_comp_any)
summary(subset(conde_nast, conde_nast$cisgendered==0)$add_comp_any)


model_1 <- lm(salary_thou ~ white + male + straight + cisgendered,data=conde_nast)


model_2 <- lm(salary_thou ~ white + male + straight + cisgendered+ yrs_exp+yrs_role,data=conde_nast)

model_3 <- lm(salary_thou ~ white + male + straight + cisgendered+ yrs_exp+yrs_role+reports_total+fulltime,data=conde_nast)


stargazer::stargazer(model_1,model_2,model_3, title="Predicting Salary", 
                     omit.stat=c("adj.rsq", "ser","f"), 
                     dep.var.labels=c("Salary in 1,000s USD"), 
                     covariate.labels=c("White","Male","Straight","Cisgendered","Years of Experience",
                                        "Years in Current Role","Total reports","Full Time"))



