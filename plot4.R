# Set working directory
# setwd("RWD")

library("ggplot2")
library("gridExtra")

df <- read.csv2("household_power_consumption.txt",header=TRUE,na.strings="?")
df$Date <- as.Date(df$Date,format="%d/%m/%Y")
df <- subset(df, Date >= as.Date("2007-02-01",format="%Y-%m-%d") & Date <= as.Date("2007-02-02",format="%Y-%m-%d"))
df <- df[complete.cases(df),]

#Create combined datetime object
df$TS <- as.POSIXct(paste(df$Date, df$Time))

myplot4_1 <- ggplot(df, aes(x=df$TS,y=as.numeric(as.character(df$Global_active_power)))) + geom_line() +
    scale_x_datetime(date_labels = "%a",date_breaks="1 day",minor_breaks=NULL) +
    xlab("") + ylab("Global Active Power") +
    theme(panel.border=element_rect(colour="black",fill=NA,size=.5),panel.grid.major=element_blank(),panel.grid.minor=element_blank()) +
    theme(panel.background = element_rect(fill="white")) + theme(axis.text.y=element_text(angle=90))
print(myplot4_1)

myplot4_2 <- ggplot(df, aes(x=df$TS)) + geom_line(aes(y=as.numeric(as.character(df$Voltage)))) +
    scale_x_datetime(date_labels = "%a",date_breaks="1 day",minor_breaks=NULL) +
    scale_y_continuous(breaks=c(234,236,238,240,242,244,246),labels=c(234,"",238,"",242,"",246)) +
    xlab("datetime") + ylab("Voltage") +
    theme(panel.border=element_rect(colour="black",fill=NA,size=.5),panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
    theme(panel.background = element_rect(fill="white")) + theme(axis.text.y=element_text(angle=90))
print(myplot4_2)

myplot4_3 <- ggplot(df, aes(x=df$TS)) + geom_line(aes(y=as.numeric(as.character(df$Sub_metering_1)),color="Sub_metering_1")) +
    geom_line(aes(y=as.numeric(as.character(df$Sub_metering_2)),color="Sub_metering_2")) +
    geom_line(aes(y=as.numeric(as.character(df$Sub_metering_3)),color="Sub_metering_3")) +
    scale_color_manual(values=c("black","red","blue")) +
    scale_x_datetime(date_labels = "%a",date_breaks="1 day",minor_breaks=NULL) +
    xlab("") + ylab("Energy sub metering") +
    theme(legend.title=element_blank(),legend.position=c(.99,.99),legend.justification=c("right","top"),legend.box.just = "right") +
    theme(legend.text=element_text(size=8), legend.key.size = unit(0.75,'lines')) +
    theme(legend.key = element_rect(fill="white",color="white")) +
    theme(panel.border=element_rect(colour="black",fill=NA,size=.5),panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
    theme(panel.background = element_rect(fill="white")) + theme(axis.text.y=element_text(angle=90))
print(myplot4_3)

myplot4_4 <- ggplot(df, aes(x=df$TS)) + geom_line(aes(y=as.numeric(as.character(df$Global_reactive_power)))) +
    scale_x_datetime(date_labels = "%a",date_breaks="1 day",minor_breaks=NULL) +
    xlab("datetime") + ylab("Global_reactive_power") +
    theme(panel.border=element_rect(colour="black",fill=NA,size=.5),panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
    theme(panel.background = element_rect(fill="white")) + theme(axis.text.y=element_text(angle=90))
print(myplot4_4)

plot4 <- grid.arrange(myplot4_1, myplot4_2, myplot4_3, myplot4_4, ncol=2)
print(plot4)

#Save the plot, 480px X 480px
ggsave("plot4.png", plot=plot4, width = 4.8, height = 4.8, dpi=100)