#if the data is already in memory, change to FALSE
readData = TRUE

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
  hpc12$DateTime<-strptime(hpc12$DateTimeChar, "%Y-%m-%d %H:%M:%S")
} 

png(filename = "plot2.png")
plot(y=hpc12$Global_active_power, x=hpc12$Temp, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()