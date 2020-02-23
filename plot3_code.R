setwd("C:/Users/jiameng.yu/Desktop/Statistics_course/Course 4 - Exploratory Data Analysis/Course Project 1")
library(dplyr)
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

##Graph 3 - time series for 3 sub metering
png(file="plot3.png")
wdays <- wday(Datetime,label=TRUE)
Sub_metering_1 <- as.numeric(as.character(electric1$Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(electric1$Sub_metering_2))
Sub_metering_3 <- as.numeric(as.character(electric1$Sub_metering_3))
electric3 <- select(electric1,-c(Sub_metering_1,Sub_metering_2, Sub_metering_3))
electric3 <- cbind(electric3,wdays, Sub_metering_1, Sub_metering_2, Sub_metering_3)
graph3 <- select(electric3,c(wdays,Datetime,Sub_metering_1, Sub_metering_2, Sub_metering_3))
plot(graph3$Datetime,graph3$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(graph3$Datetime,graph3$Sub_metering_1,col="black")
lines(graph3$Datetime,graph3$Sub_metering_2,col="red")
lines(graph3$Datetime,graph3$Sub_metering_3,col="blue")
locations = floor(seq(from=1,to=nrow(graph3),by=nrow(graph3)/3))
axis(side = 1, at = locations, labels=graph3$wdays[locations],las=2)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","blue","red"),bty="n")
dev.off()