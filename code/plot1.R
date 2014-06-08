# =====================================================================
# Coursera - Exporatory Data Analysis
# Project 1 - plot1.R
# 6/6/2014
# =====================================================================

# ---------------------------------------------------------------------
# cleanup
# ---------------------------------------------------------------------
rm(list=ls(all=TRUE)) 

# ---------------------------------------------------------------------
# set working directory
# ---------------------------------------------------------------------
setwd ("c:/r/code/exdata/project1")

# ---------------------------------------------------------------------
# read source data
# initial read is used to determine column classes
# ---------------------------------------------------------------------

rawdata5rows <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", nrows=10)
classes      <- sapply(rawdata5rows, class)
rawdata1     <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = classes, na.strings = "?")
rm(rawdata5rows)
rm(classes)

# ---------------------------------------------------------------------
# summarize data
# ---------------------------------------------------------------------

# summary(rawdata)
# str(rawdata)

# ---------------------------------------------------------------------
# add converted date column
# ---------------------------------------------------------------------

date <- as.Date(rawdata1$Date, format="%d/%m/%Y")
rawdata2 <- cbind (rawdata1, date)
rm(rawdata1)
rm(date)

# ---------------------------------------------------------------------
# subset the data by date range
# ---------------------------------------------------------------------

rawdata3 <- subset(rawdata2, date >= "2007-02-01" & date <= "2007-02-02")
rm(rawdata2)

# ---------------------------------------------------------------------
# add converted datetime column
# ---------------------------------------------------------------------

datetime <- strptime(paste(rawdata3$Date, rawdata3$Time), "%d/%m/%Y %H:%M:%S")
power_data <- cbind (rawdata3, datetime)
rm(rawdata3)
rm(datetime)

# ---------------------------------------------------------------------
# Plot 1
# ---------------------------------------------------------------------

png(file="plot1.png",width=480,height=480,res=55)
hist(power_data$Global_active_power, col="Red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
