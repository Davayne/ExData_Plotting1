## Set Working Directory
setwd("C://Users//Devayne//Desktop//Data Specialization Course//Exploratory Data Analysis//Assignment1")

## Step 1: Download Zipfile from Website and save to a folder in Working Directory
if(!file.exists("Assignment1")){dir.create("Assignment1")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile="exdata-data-household_power_consumption.zip")
dateDownloaded <- date()

### get list of files in downloaded data
unzip("exdata-data-household_power_consumption.zip", list = TRUE)  ## get list of files within the zipped folder

## Step 2: Unzip the needed file and read into a dataframe 
data_zipped <- unzip("exdata-data-household_power_consumption.zip","household_power_consumption.txt", list = FALSE)
data <- read.table(data_zipped, header= TRUE, sep = ";", na.strings = "?", numerals = c("allow.loss"), 
                   colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

## subset data to get only the two needed dates
data1 <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

library(dplyr)  ### install package to manipulate data
library(lubridate)   ### install package to handle time

data2 <- mutate(data1, datetime = dmy_hms(paste(Date, Time) ))  ## add column that is combination of date & time

par(mfrow = c(2,2))
### Create Plot
plot(data2$datetime, data2$Global_active_power, type="n", ylab = "Global Active Power (kilowatts)", xlab ="", pin = c(6,6))
lines(data2$datetime, data2$Global_active_power, type = "l")  

### Create Plot2
plot(data2$datetime, data2$Voltage, type="n", ylab = "Voltage", xlab ="Datetime", pin = c(6,6))
lines(data2$datetime, data2$Voltage, type = "l")  

### Create Plot3
plot(data2$datetime, data2$Sub_metering_1,  type = "n",  ylab = "Energy sub Metering", xlab ="", pin = c(6,6))
lines(data2$datetime, data2$Sub_metering_1, col = "black", type = "l", lwd = 0.5)
lines(data2$datetime, data2$Sub_metering_2, col = "red", type = "l", lwd = 0.5)
lines(data2$datetime, data2$Sub_metering_3, col = "blue", type = "l", lwd = 0.5)
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), pch = "", 
       col = c("black", "red", "blue"), lty = c(1,1,1), cex = 0.75)

### Create Plot2
plot(data2$datetime, data2$Global_reactive_power, type="n", ylab = "Global_reactive_power", xlab ="Datetime", pin = c(6,6))
lines(data2$datetime, data2$Global_reactive_power, type = "l")  

dev.copy(png, file = "plot4.png") ## copy plot to a png file
dev.off() ## close PNG device
