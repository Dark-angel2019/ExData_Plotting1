setwd("C:/Users/jiameng.yu/Desktop/Statistics_course/Course 4 - Exploratory Data Analysis/Course Project 1")
library(dplyr)
library("lubridate")
## reading the relevant part of data
electric <- read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows=70000)
## extracting relevant parts of data as filter doesnt seem to work
firstdate<- grep("1/2/2007",electric$Date)
enddate<- grep("2/2/2007",electric$Date)
a <- firstdate[1]
b <- enddate[length(enddate)]
electric1 <- electric[a:b,]

## converting date and time format + adding wday elements
Datetime <- paste(electric1$Date,electric1$Time,sep=" ")
Datetime <- strptime(Datetime, format="%d/%m/%Y %H:%M:%S", tz="")
electric1<- cbind(Datetime,electric1)

##Graph 2 - simple time series of Global_Active_Power
png(file="plot2.png",)
wdays <- wday(Datetime,label=TRUE)
Global_Active_Power <- as.numeric(as.character(electric1$Global_active_power))
electric2 <- cbind(electric1,Global_Active_Power,wdays)
graph2 <- select(electric2,c(wdays,Datetime,Global_Active_Power))
plot(graph2$Datetime, graph2$Global_Active_Power, type="n", xlab="", ylab="Global Active Power")
lines(graph2$Datetime, graph2$Global_Active_Power)
locations = floor(seq(from=1,to=nrow(graph2),by=nrow(graph2)/3))
axis(side = 1, at = locations, labels=graph2$wdays[locations],las=2)
dev.off()


