here::i_am("R/covid_plot.R")

#install and load necessary packages
if(!require("readr"))(install.packages("readr"))
library("readr")
if(!require("readxl"))(install.packages("readxl"))
library("readxl")
if(!require("dplyr"))(install.packages("dplyr"))
library("dplyr")
if(!require("lubridate"))(install.packages("lubridate"))
library("lubridate")
if(!require("ggplot2"))(install.packages("ggplot2"))
library("ggplot2")

#load the data (packages used: readr, readxl)
#-->Virginia Covid-19 outcome data (specify column names so 
#-->that they follow the desired naming convention)
covid_cases <- read_csv("../Data/VDH-COVID-19-PublicUseDataset-Cases.csv",
                        skip=1,
                        col_names=c("report_date", "FIPS",
                                    "locality", "VDH_district",
                                    "total_cases", "hospitalizations",
                                    "deaths")) 
#-->Census Income Data (need to specify which rows and 
#-->columns and list column names and types because of 
#-->the formatting in the original dataset)
income <- read_excel("../Data/county5.xls", 
                     range="MG2000!B2824:K2959", 
                     col_names=c("county", "FIPS", 
                                 "GINI", "mean_income"), 
                     col_types=c("text", "numeric", 
                                 "skip", "numeric", 
                                 "skip", "skip", 
                                 "skip", "skip", 
                                 "skip", "numeric"))

#clean the data (packages used: dplyr, lubridate)
#-->connect the two datasets using the FIPS column
VA_covid_messy <- covid_cases %>% 
  full_join(income, by="FIPS", na.rm=T) %>% 
  select(report_date, FIPS, locality, 
         VDH_district, GINI, 
         mean_income, total_cases, 
         hospitalizations, deaths)
VA_covid_messy[!complete.cases(VA_covid_messy),]
VA_covid <- na.omit(VA_covid_messy)
VA_covid[!complete.cases(VA_covid),]
VA_covid$report_date <- sort(as.Date(VA_covid$report_date, 
                                     format="%m/%d/%Y"))
#-->epiweek (from lubridate package) gives the number of 
#-->weeks during a time period but starts on a Sunday, which 
#-->is the start of the week in the Virginia Covid-19 data
start_week <- epiweek(VA_covid$report_date[1])
VA_covid <- VA_covid %>% mutate(report_week=case_when(
  year(report_date) == 2020 ~ epiweek(report_date)-start_week,
  year(report_date) == 2021 ~ epiweek(report_date)-start_week+52
))
VA_covid <- VA_covid %>% 
  mutate(GINI_quartile=ntile(GINI, 4))
head(VA_covid)

#create a spaghetti plot (packages used: ggplot2)
#-->create a plot of deaths per week, stratified by 
#-->the GINI coefficient quartiles, then output as a png
png(here::here("output", "covid_plot.png"))
  ggplot(VA_covid, 
         aes(x=report_week, y=deaths, 
             group=FIPS, color=factor(FIPS))) + 
    geom_line() + 
    facet_grid(. ~ GINI_quartile, 
               labeller=labeller(GINI_quartile=c("1"="GINI 1st Quartile", 
                                                 "2"="GINI 2nd Quartile", 
                                                 "3"="GINI 3rd Quartile", 
                                                 "4"="GINI 4th Quartile")))+ 
    guides(colour="none") + 
    xlab("Weeks since 3/17/20") + 
    ylab("Deaths from COVID-19") + 
    labs(title="COVID-19 deaths over time, stratified by inequality") + 
    theme(plot.title=element_text(hjust = 0.5))
dev.off()
