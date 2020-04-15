## download the raw data

url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download.file(url = url, 'plotting_data.zip')

## unzip and save 
unzip('plotting_data.zip')

### read into a dataframe (first 100k records)
dat <- read.csv('household_power_consumption.txt', sep = ';', 
                header = TRUE, nrow= 1E5, stringsAsFactors = FALSE )

#create datetime column 
dat$Datetime <- paste(dat$Date, dat$Time, sep = ' ') 
dat$Datetime <- strptime(dat$Datetime, '%d/%m/%Y %H:%M:%S')
### convert time columns 
dat$Date <- as.Date(dat$Date, '%d/%m/%Y')


## filter to only the relevant records for the assignment
#### otherwise the size of the data frame is too large 
dat <- dat[dat$Date %in% c(as.Date('2007-02-01'),as.Date('2007-02-02')),]

## format columns 
dat$Time <- format(strptime(dat$Time, '%H:%M:%S'),'%H:%M:%S')
dat$Global_active_power <- as.numeric(dat$Global_active_power)
dat$Global_reactive_power <- as.numeric(dat$Global_reactive_power)
dat$Voltage <- as.numeric(dat$Voltage)
dat$Global_intensity <- as.numeric(dat$Global_intensity)
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)


## open the graphics device 
png('plot4.png',width = 480, height = 480)

## parameters for the combined plots 
par(mfrow=c(2,2), mar=c(4,4,1,1),
    oma = c(1,1,1,1))

# first plot 
plot(x=dat$Datetime, y=dat$Global_active_power, type = 'l',
                      ylab = 'Global Active Power', xlab = '')

# second plot 
plot(dat$Datetime, dat$Voltage, type='l', ylab = 'Voltage', xlab = 'datetime')

#third plot 
plot(x=dat$Datetime, y=dat$Sub_metering_1,
     col='black',xlab='', ylab = 'Energy sub metering', type = 'n')
lines(x=dat$Datetime, y=dat$Sub_metering_1,
      col='black')

lines(x=dat$Datetime, y=dat$Sub_metering_2, 
      col='red')

lines(x=dat$Datetime, y=dat$Sub_metering_3, 
      col='blue' )

legend('topright',
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col = c('black','red','blue'), lty = rep(1,3))

#fourth plot 
plot(x = dat$Datetime, y = dat$Global_reactive_power, type = 'o',
     pch = 3, cex=0.3, ylab ='Global_reactive_power', xlab = 'datetime')

dev.off() 






