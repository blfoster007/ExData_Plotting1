# Set working directory
# setwd("RWD")

library("ggplot2")

df <- read.csv2("household_power_consumption.txt",header=TRUE,na.strings="?")
df$Date <- as.Date(df$Date,format="%d/%m/%Y")
df <- subset(df, Date >= as.Date("2007-02-01",format="%Y-%m-%d") & Date <= as.Date("2007-02-02",format="%Y-%m-%d"))
df <- df[complete.cases(df),]

#Create combined datetime object
df$TS <- as.POSIXct(paste(df$Date, df$Time))

myplot <- ggplot(df, aes(x=df$TS)) + geom_line(aes(y=as.numeric(as.character(df$Sub_metering_1)),color="Sub_metering_1")) +
    geom_line(aes(y=as.numeric(as.character(df$Sub_metering_2)),color="Sub_metering_2")) +
    geom_line(aes(y=as.numeric(as.character(df$Sub_metering_3)),color="Sub_metering_3")) +
    scale_color_manual(values=c("black","red","blue")) +
    scale_x_datetime(date_labels = "%a",date_breaks="1 day",minor_breaks=NULL) +
    xlab("") + ylab("Energy sub metering") +
    theme(legend.title=element_blank(),legend.position=c(1.0,1.0),legend.justification=c("right","top"),legend.box.just = "right") +
    theme(legend.background = element_rect(color = "black", size = .5, linetype = "solid")) +
    theme(legend.key = element_rect(fill="white",color="white")) +
    theme(panel.border=element_rect(colour="black",fill=NA,size=.5),panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
    theme(panel.background = element_rect(fill="white")) + theme(axis.text.y=element_text(angle=90))

#Render the plot
print(myplot)

#Save the plot, 480px X 480px
ggsave("plot3.png", width = 4.8, height = 4.8, dpi=100)