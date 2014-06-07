#download and read the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method="curl")
a<-unz("household_power_consumption.zip", "household_power_consumption.txt")
hpc<-read.table(a, header=T, sep=";")

#convert the date format
hpc$Date<-as.Date(hpc$Date, format="%d/%m/%Y")
hpc2<-hpc[hpc$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

#make the plot and print to png file
png(filename="plot3.png", width=480, height=480)
par(lab=c(4,3,3))
plot(as.numeric(as.character(hpc2$Sub_metering_1)), xaxt="n", type="l", ylab="Energy sub metering", xlab="", xaxp=c(0, length(hpc2$Date), 2))
axis(1, at=c(0, length(hpc2$Date[hpc2$Date==as.Date("2007-02-01")]), nrow(hpc2)), labels=c("Thu", "Fri", "Sat"))
points(as.numeric(as.character(hpc2$Sub_metering_2)), col="red", type="l")
points(as.numeric(as.character(hpc2$Sub_metering_3)), col="blue", type="l")
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), cex=1)
dev.off()