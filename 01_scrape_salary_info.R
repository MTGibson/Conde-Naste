rm(list=ls())

library('dplyr')
library('tidyr')
library('rvest')
library('ggplot2')
library('tidyverse')


setwd("/Users/michaelgibson/Documents/GitHub/Conde-Naste")
conde_nast <- read_html("https://docs.google.com/spreadsheets/u/1/d/1YqdJCJ3LmtVIzxsgOj-YhE8fGBQ3zhuEkWp-_og2HEE/htmlview?pru=AAABcsoMglg*NgqVwN1JSbezwnZ9b6PYNg")

title <- conde_nast %>%
  html_nodes(".s8:nth-child(2)") %>%
  html_text() %>%
  readr::parse_character()

salary <- conde_nast %>%
  html_nodes(".s9:nth-child(3)") %>%
  html_text() %>%
  readr::parse_number()

race <- conde_nast %>%
  html_nodes(".s8:nth-child(4)") %>%
  html_text() %>%
  readr::parse_character()

gender <- conde_nast %>%
  html_nodes(".s8:nth-child(5)") %>%
  html_text() %>%
  readr::parse_character()

sex_orien <- conde_nast %>%
  html_nodes(".s8:nth-child(6)") %>%
  html_text() %>%
  readr::parse_character()

status <- conde_nast %>%
  html_nodes(".s8:nth-child(7)") %>%
  html_text() %>%
  readr::parse_character()

yrs_role <- conde_nast %>%
  html_nodes(".s9:nth-child(8)") %>%
  html_text() %>%
  readr::parse_number()

yrs_exp <- conde_nast %>%
  html_nodes(".s9:nth-child(8)") %>%
  html_text() %>%
  readr::parse_character()

reports_ind <- conde_nast %>%
  html_nodes(".s9:nth-child(10)") %>%
  html_text() %>%
  readr::parse_number()

reports_dir <- conde_nast %>%
  html_nodes(".s9:nth-child(11)") %>%
  html_text() %>%
  readr::parse_number()

add_comp <- conde_nast %>%
  html_nodes("td:nth-child(12)") %>%
  html_text() %>%
  readr::parse_character()

other <- conde_nast %>%
  html_nodes(".s10:nth-child(13)") %>%
  html_text() %>%
  readr::parse_character()

combined <- data_frame(title, salary, gender, race, sex_orien, yrs_exp, yrs_role, add_comp, reports_dir, reports_ind, other)

raw <- data_frame(title, salary, gender, race, sex_orien, yrs_exp, yrs_role)


write.csv(raw,'raw_cn.csv') 
