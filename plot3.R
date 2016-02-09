
## download data
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

## read data

d<-read.table(file, header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE)

d$Date<-as.Date(d$Date, "%d/%m/%Y")
d<-subset(d, d$Date=="2007-02-01" | d$Date=="2007-02-02")


## process data

d <- transform(d, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
for (i in 3:9)
{d[,i]<-as.numeric(d[,i])}


# Plot data


plot(d$timestamp, d$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering")
lines(d$timestamp, d$Sub_metering_2, col="red")
lines(d$timestamp, d$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), lwd=c(1,1))
#save to png file

dev.copy(png, file="plot3.png",  width = 480, height = 480, units = "px")

dev.off()