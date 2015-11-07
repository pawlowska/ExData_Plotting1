#if the data is already in memory, change to FALSE
readData = T

if(readData) {
  #read the file
  hpc <- read.csv2("household_power_consumption.txt")
  #choose relevant data and discard the rest to save memory
  hpc12 <- hpc[66637:69516,]
  rm(hpc)
  hpc12[,1:2] <- lapply(hpc12[,1:2], function(x) as.character(x))
  hpc12[,3:9] <- lapply(hpc12[,3:9], function(x) as.numeric(as.character(x)))
  #to generate the weekdays from the date and time:
  Sys.setlocale("LC_ALL","English")
  hpc12$DateTimeChar <- paste(hpc12$Date, hpc12$Time)
  hpc12$DateTime<-strptime(hpc12$DateTimeChar, "%d/%m/%Y %H:%M:%S")
}  

png(filename = "plot4.png")
par(mfrow = c(2,2))
with(hpc12, {
  plot(y=Global_active_power, x=DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  plot(y=Voltage, x=DateTime, type = "l", xlab = "datetime")
  
  plot(y=Sub_metering_1, x=DateTime, type = "l", col = "black", xlab="", ylab = "Energy sub metering")
  lines(y=Sub_metering_2, x=DateTime, type = "l", col = "red")
  lines(y=Sub_metering_3, x=DateTime, col="blue")
  legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(y=Global_reactive_power, x=DateTime, type = "l", xlab="datetime")
  
}
)

dev.off()