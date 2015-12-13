## Loading the lubridate library in the session to compute date/time
library(lubridate)

## Read the file to File1 variable
File1 <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?")

## Get the required data from main File to required date range data using subset option
File1_Subset <- subset(File1, as.Date(File1$Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(File1$Date, format = "%d/%m/%Y") < "2007-02-03")

## Remove the main file to free the memory
rm(File1)

## concat the Date and time using paste function
Date_time <- paste(File1_Subset$Date, File1_Subset$Time)

## Convert the concatenated Date time variable to data/time
Date_time <- dmy_hms(Date_time, tz ="EST")

## Column bind the Date/Time data
File_Column_Concat <- cbind(File1_Subset, Date_time)

## Numeric values needed for Plot
File_Column_Concat$Global_active_power <- as.numeric(File_Column_Concat$Global_active_power)

## Plot the Histogram for Global Active Power
hist(File_Column_Concat$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving histogram to png file format
dev.copy(png, file="Plot1.png", height=480, width=480)
dev.off()
