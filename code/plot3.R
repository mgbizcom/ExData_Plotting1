# =====================================================================
# Coursera - Exploratory Data Analysis
# Project 1 - plot3.R
# 6/8/2014
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
# Plot 3
# ---------------------------------------------------------------------

png(file="plot3.png",width=480,height=480,res=55)
with(power_data, plot(datetime, Sub_metering_1, main = "", ylab="Energy sub metering", xlab="", type = "n"))
with(power_data, points(datetime, Sub_metering_1, type="l", col = "black"))
with(power_data, points(datetime, Sub_metering_2, type="l", col = "red"))
with(power_data, points(datetime, Sub_metering_3, type="l", col = "blue"))
legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()