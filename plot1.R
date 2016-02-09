
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


## processing data

d <- transform(d, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
for (i in 3:9)
{d[,i]<-as.numeric(d[,i])}


# Ploting data


hist(d$Global_active_power, col="red", main='Global Active Power', xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")

##saving to png file

dev.copy(png, file="plot1.png",  width = 480, height = 480, units = "px")

dev.off()