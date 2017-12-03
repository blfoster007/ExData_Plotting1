# Set working directory
# setwd("RWD")

library("ggplot2")

df <- read.csv2("household_power_consumption.txt",header=TRUE,na.strings="?")
df$Date <- as.Date(df$Date,format="%d/%m/%Y")
df <- subset(df, Date >= as.Date("2007-02-01",format="%Y-%m-%d") & Date <= as.Date("2007-02-02",format="%Y-%m-%d"))
df <- df[complete.cases(df),]

#Create combined datetime object
df$TS <- as.POSIXct(paste(df$Date, df$Time))

myplot <- ggplot(df, aes(x=df$TS,y=as.numeric(as.character(df$Global_active_power)))) + geom_line() +
    scale_x_datetime(date_labels = "%a",date_breaks="1 day",minor_breaks=NULL) +
    xlab("") + ylab("Global Active Power (kilowatts)") +
    theme(panel.border=element_rect(colour="black",fill=NA,size=.5),panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
    theme(panel.background = element_rect(fill="white")) + theme(axis.text.y=element_text(angle=90))

#Render the plot
print(myplot)

#Save the plot, 480px X 480px
ggsave("plot2.png", width = 4.8, height = 4.8, dpi=100)