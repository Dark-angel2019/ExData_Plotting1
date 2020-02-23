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


##Graph 1 - histogram of Global Active Power
png(file="plot1.png")
graph1<- as.numeric(as.character(electric1$Global_active_power))
hist(graph1,col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")                 
dev.off()
                  