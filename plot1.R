# Set working directory
# setwd("RWD")

df <- read.csv2("household_power_consumption.txt",header=TRUE,na.strings="?")
df$Date <- as.Date(df$Date,format="%d/%m/%Y")
df <- subset(df, Date >= as.Date("2007-02-01",format="%Y-%m-%d") & Date <= as.Date("2007-02-02",format="%Y-%m-%d"))
df <- df[complete.cases(df),]

#Print to Plots windows
hist(as.numeric(as.character(df$Global_active_power)),
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red")

#Begin print to file
png(filename = "plot1.png", width = 480, height = 480, units = "px")

hist(as.numeric(as.character(df$Global_active_power)),
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red")

dev.off()