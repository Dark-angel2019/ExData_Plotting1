setwd("C:/Users/jiameng.yu/Desktop/Statistics_course/Course 4 - Exploratory Data Analysis/Course Project 1")
library(dplyr)
library(lubridate)
## reading the relevant part of data
electric <- read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows=70000)
## extracting relevant parts of data as filter doesnt seem to work
firstdate<- grep("1/2/2007",electric$Date)
enddate<- grep("2/2/2007",electric$Date)
a <- firstdate[1]
b <- enddate[length(enddate)]
electric1 <- electric[a:b,]

## converting date and time format + adding wday elements + converting relevant 
## variables to numeric
Datetime <- paste(electric1$Date,electric1$Time,sep=" ")
Datetime <- strptime(Datetime, format="%d/%m/%Y %H:%M:%S", tz="")
wdays <- wday(Datetime,label=TRUE)
electric1<- cbind(Datetime,wdays,electric1)
electric2<- select(electric1, c(Datetime,wdays))
Sub_metering_1 <- as.numeric(as.character(electric1$Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(electric1$Sub_metering_2))
Sub_metering_3 <- as.numeric(as.character(electric1$Sub_metering_3))
Global_Active_Power<- as.numeric(as.character(electric1$Global_active_power))
Voltage<- as.numeric(as.character(electric1$Voltage))
Global_reactive_power<- as.numeric(as.character(electric1$Global_reactive_power))
electric3<- cbind(electric2,Global_Active_Power,Voltage,Global_reactive_power,Sub_metering_1,Sub_metering_2,Sub_metering_3)

##Graph 4 - 4 spearate graphs
png(file="plot4.png")
par(mfrow=c(2,2), mar=c(4,4,3,2))
## top left plot
plot(electric3$Datetime, electric3$Global_Active_Power, type="n", xlab="", ylab="Global Active Power")
lines(electric3$Datetime, electric3$Global_Active_Power)
locations = floor(seq(from=1,to=nrow(electric3),by=nrow(electric3)/3))
axis(side = 1, at = locations, labels=electric3$wdays[locations],las=2)

## top right plot
plot(electric3$Datetime, electric3$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(electric3$Datetime, electric3$Voltage)
locations = floor(seq(from=1,to=nrow(electric3),by=nrow(electric3)/3))
axis(side = 1, at = locations, labels=electric3$wdays[locations],las=2)

## bottom left plot
plot(electric3$Datetime,electric3$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(electric3$Datetime,electric3$Sub_metering_1,col="black")
lines(electric3$Datetime,electric3$Sub_metering_2,col="red")
lines(electric3$Datetime,electric3$Sub_metering_3,col="blue")
locations = floor(seq(from=1,to=nrow(electric3),by=nrow(electric3)/3))
axis(side = 1, at = locations, labels=electric3$wdays[locations],las=2)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","blue","red"),bty="n")

## bottom right plot
plot(electric3$Datetime, electric3$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(electric3$Datetime, electric3$Global_reactive_power)
locations = floor(seq(from=1,to=nrow(electric3),by=nrow(electric3)/3))
axis(side = 1, at = locations, labels=electric3$wdays[locations],las=2)

dev.off()