#download and read the file containing the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method="curl")
a<-unz("household_power_consumption.zip", "household_power_consumption.txt")
hpc<-read.table(a, header=T, sep=";")

#convert the date format
hpc$Date<-as.Date(hpc$Date, format="%d/%m/%Y")
hpc2<-hpc[hpc$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

#make plot and print to png file
png(filename="plot2.png", width=480, height=480)
par(lab=c(4,3,3))
plot(as.numeric(as.character(hpc2$Global_active_power)), xaxt="n", type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxp=c(0, length(hpc2$Date), 2))
axis(1, at=c(0, length(hpc2$Date[hpc2$Date==as.Date("2007-02-01")]), nrow(hpc2)), labels=c("Thu", "Fri", "Sat"))
dev.off()