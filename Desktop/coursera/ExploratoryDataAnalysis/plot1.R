#download and read the file containing the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method="curl")
a<-unz("household_power_consumption.zip", "household_power_consumption.txt")
hpc<-read.table(a, header=T, sep=";")

#convert the date format
hpc$Date<-as.Date(hpc$Date, format="%d/%m/%Y")
hpc2<-hpc[hpc$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

#make the histogram and print to png file
png(filename="plot1.png", width=480, height=480)
par(lab=c(4,7,7))
hist(as.numeric(as.character(hpc2$Global_active_power)), col="orangered", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()