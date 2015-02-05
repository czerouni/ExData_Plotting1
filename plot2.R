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

# draw the plot into the file
png('plot2.png')
plot(theDay$Date, theDay$Global_active_power, type="l",
    xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

