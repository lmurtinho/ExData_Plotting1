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

# save histogram of global active power on png file
png("plot1.png")
hist(df$Global_active_power, main = "Global active power", col="red",
     xlab = "Global active power (kilowatts)")
dev.off()
rm(list = ls())