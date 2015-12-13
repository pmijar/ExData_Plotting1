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
File_Column_Concat$Global_reactive_power <- as.numeric(File_Column_Concat$Global_reactive_power)
File_Column_Concat$Voltage <- as.numeric(File_Column_Concat$Voltage)

## Initializing the plot parameter at global level
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0), cex = 0.7, pty = "m")
with(File_Column_Concat,{
  plot(Date_time, Global_active_power, xlab="", ylab="Global Active Power", col="Black", type = "l")
  plot(Date_time, Voltage, type="l",xlab="datetime", ylab="Voltage" )
  plot(File_Column_Concat$Date_time, File_Column_Concat$Sub_metering_1, col = "Black", xlab = "", ylab = "Energy sub metering", type = "l")
  lines(File_Column_Concat$Date_time, File_Column_Concat$Sub_metering_2, col = "Red")
  lines(File_Column_Concat$Date_time, File_Column_Concat$Sub_metering_3, col = "Blue")
  legend("topright",lwd=c(1,1) , bty = "n", xjust = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Date_time, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
}
)

## Saving histogram to png file format
dev.copy(png, file="Plot4.png", height=480, width=480)
dev.off()

