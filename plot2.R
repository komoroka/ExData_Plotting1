## download the raw data

url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download.file(url = url, 'plotting_data.zip')

## unzip and save 
unzip('plotting_data.zip')

### read into a dataframe 
dat <- read.csv('household_power_consumption.txt', sep = ';', 
                header = TRUE, nrow= 1E5, stringsAsFactors = FALSE )

dat$Datetime <- paste(dat$Date, dat$Time, sep = ' ') 
dat$Datetime <- strptime(dat$Datetime, '%d/%m/%Y %H:%M:%S')
### convert time columns 
dat$Date <- as.Date(dat$Date, '%d/%m/%Y')


## filter to only the relevant records for the assignment
#### otherwise the size of the data frame is too large 
dat <- dat[dat$Date %in% c(as.Date('2007-02-01'),as.Date('2007-02-02')),]

dat$Time <- format(strptime(dat$Time, '%H:%M:%S'),'%H:%M:%S')
dat$Global_active_power <- as.numeric(dat$Global_active_power)
dat$Global_reactive_power <- as.numeric(dat$Global_reactive_power)
dat$Voltage <- as.numeric(dat$Voltage)
dat$Global_intensity <- as.numeric(dat$Global_intensity)
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)

## Plot #2 
png('plot2.png', width = 480, height = 480)
plot(x=dat$Datetime, y=dat$Global_active_power, type = 'l',
     ylab = 'Global Active Power (kilowatts)', xlab = '')
dev.off() 

