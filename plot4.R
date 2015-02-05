# read the table - since we only want one day in 2007, speed this up by 
# not reading past 200,000 lines. That number was derived by looking at
# the data - we stop somewhere in April, which is plenty

# Read the file, stop after 
data = read.table("household_power_consumption.txt",
                  header = TRUE,
                  sep = ";",
                  na.strings = "?",
                  comment.char = "",
                  nrows = 200000)

# convert dates from factors to Dates/Times so we can compare them
data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

# now get the subset of the data we care about
theDay <- subset(data, Date >= "2007-02-01 00:00:00" 
                     & Date <= "2007-02-02 24:00:00")

# open the file
png('plot4.png')

# set up the 2x2 matrix
par(mfrow = c(2, 2))

# draw the plot into the file
plot(theDay$Date, theDay$Global_active_power, type="l",
            xlab = "", ylab = "Global Active Power")

plot(theDay$Date, theDay$Voltage, type="l",
    xlab = "datetime", ylab = "Voltage")

plot(theDay$Date, theDay$Sub_metering_1, type="l",
    xlab = "", ylab = "Energy sub metering")
lines(theDay$Date, theDay$Sub_metering_2, col="red")
lines(theDay$Date, theDay$Sub_metering_3, col="blue")
legend("topright", bty="n",
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty=c(1, 1, 1), col=c("black", "red", "blue"))

plot(theDay$Date, theDay$Global_reactive_power, type="l",
    xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
