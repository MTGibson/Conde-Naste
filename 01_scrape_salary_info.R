rm(list=ls())

library('dplyr')
library('tidyr')
library('rvest')
library('ggplot2')
library('tidyverse')
library("XML")
library("googlesheets4")

setwd("/Users/michaelgibson/Documents/GitHub/Conde-Naste")

gs4_browse("https://docs.google.com/spreadsheets/u/1/d/1YqdJCJ3LmtVIzxsgOj-YhE8fGBQ3zhuEkWp-_og2HEE/htmlview?pru=AAABcsoMglg*NgqVwN1JSbezwnZ9b6PYNg")
cnast<-range_read("https://docs.google.com/spreadsheets/u/1/d/1YqdJCJ3LmtVIzxsgOj-YhE8fGBQ3zhuEkWp-_og2HEE/htmlview?pru=AAABcsoMglg*NgqVwN1JSbezwnZ9b6PYNg")	

