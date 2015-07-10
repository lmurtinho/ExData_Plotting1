# download and unzip file
if (!"household_power_consumption.txt" %in% list.files()) {
  if (! "household_power_consumption.zip" %in% list.files()) {
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  "household_power_consumption.zip")
  }
  unzip("household_power_consumption.zip")
}

# read only data from dates of interest
library(sqldf)
df <- read.csv.sql("household_power_consumption.txt", sep=";",
                   sql = "select * from file where Date in ('1/2/2007', '2/2/2007')")

# set Time as Time class
df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

# save line graph of energy sub meterings on png file
png("plot3.png")
plot(df$Time, df$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(df$Time, df$Sub_metering_1, col="black")
lines(df$Time, df$Sub_metering_2, col="red")
lines(df$Time, df$Sub_metering_3, col="blue")
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
                     lty=c(1, 1, 1), col=c("black", "red", "blue"))

# clean up and leave
dev.off()
rm(list = ls())