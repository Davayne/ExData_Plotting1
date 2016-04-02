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

str(data)

### Create Histogram and then Copy to a PNG file in working Directory
hist(data1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )
dev.copy(png, file = "plot1.png") ## copy plot to a png file
dev.off() ## close PNG device
