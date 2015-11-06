hpc <- read.csv2("household_power_consumption.txt")
hpc12 <- hpc[66637:69516,]
rm(hpc)
hpc12[,1:2] <- lapply(hpc12[,1:2], function(x) as.character(x))
Sys.setlocale("LC_ALL","English")
hpc12$DateTimeChar <- paste(hpc12$Date, hpc12$Time)
hpc12$DateTime<-strptime(hpc12$DateTimeChar, "%Y-%m-%d %H:%M:%S")
hpc12[,3:9] <- lapply(hpc12[,3:9], function(x) as.numeric(as.character(x)))

png(filename = "plot3.png")
with(hpc12,{
  plot(y=Sub_metering_1, x=DateTime, type = "l", col = "black", xlab="", ylab = "Energy sub metering")
  lines(y=Sub_metering_2, x=DateTime, type = "l", col = "red")
  lines(y=Sub_metering_3, x=DateTime, col="blue")
  legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}
)
dev.off()