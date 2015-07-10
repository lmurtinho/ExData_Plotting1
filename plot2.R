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

# save line graph of global active power on png file
png("plot2.png")
plot(df$Time, df$Global_active_power, type="n", xlab = "", ylab = "Global active power (kilowatts)")
lines(df$Time, df$Global_active_power)
dev.off()
rm(list = ls())