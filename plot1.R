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
} 

png(filename = "plot1.png")
hist(hpc12$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
