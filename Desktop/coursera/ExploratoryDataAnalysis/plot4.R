#download and read the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method="curl")
a<-unz("household_power_consumption.zip", "household_power_consumption.txt")
hpc<-read.table(a, header=T, sep=";")

#convert the date format
hpc$Date<-as.Date(hpc$Date, format="%d/%m/%Y")
hpc2<-hpc[hpc$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

#make the panel plots and print to png file
png(filename="plot4.png", width=480, height=480)

par(mfrow=c(2,2), lab=c(4,3,3), cex.lab=0.92)

#plot global active power vs time
plot(as.numeric(as.character(hpc2$Global_active_power)), xaxt="n", type="l", ylab="Global Active Power", xlab="", xaxp=c(0, length(hpc2$Date), 2))
axis(1, at=c(0, length(hpc2$Date[hpc2$Date==as.Date("2007-02-01")]), nrow(hpc2)), labels=c("Thu", "Fri", "Sat"))

#plot voltage vs time
plot(as.numeric(as.character(hpc2$Voltage)), xaxt="n", type="l", ylab="Voltage", xlab="datetime", 
     xaxp=c(0, length(hpc2$Date), 2), yaxp=c(234, 246, 6))
axis(1, at=c(0, length(hpc2$Date[hpc2$Date==as.Date("2007-02-01")]), nrow(hpc2)), labels=c("Thu", "Fri", "Sat"))

#plot energy sub metering 1, 2, and 3
plot(as.numeric(as.character(hpc2$Sub_metering_1)), xaxt="n", type="l", 
     ylab="Energy sub metering", xlab="", xaxp=c(0, length(hpc2$Date), 2))
axis(1, at=c(0, length(hpc2$Date[hpc2$Date==as.Date("2007-02-01")]), nrow(hpc2)), labels=c("Thu", "Fri", "Sat"))
points(as.numeric(as.character(hpc2$Sub_metering_2)), col="red", type="l")
points(as.numeric(as.character(hpc2$Sub_metering_3)), col="blue", type="l")
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), bty="n",cex=0.95)

#plot global reactive power
plot(as.numeric(as.character(hpc2$Global_reactive_power)), xaxt="n", type="l", ylab="Global_reactive_power", 
     xlab="datetime", xaxp=c(0, length(hpc2$Date), 2), yaxp=c(0, 0.5, 5))
axis(1, at=c(0, length(hpc2$Date[hpc2$Date==as.Date("2007-02-01")]), nrow(hpc2)), labels=c("Thu", "Fri", "Sat"))
dev.off()