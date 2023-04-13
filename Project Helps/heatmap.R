library(tidyverse)

#syntenet 
#synteny 
#heatmap 


#bioconductor


today <- Sys.Date()
#todays date

class(today)

#class is a date not a character 

as.POSIXct()
#international standard for how dates are stored
#SI way of dates 

day <- "2/11/2021" %>% as.POSIXct(format="%m/%d/%Y", tz= "MST")
#posixct format = class 

lubridate::day(day)
lubridate::days_in_month(day)

weekdays(day)

#also a holidays package 

#shiny package for app development 

prophet()