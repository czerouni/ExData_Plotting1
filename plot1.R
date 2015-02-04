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

# convert dates from factors to Dates so we can compare them
data[1] = as.Date(as.character(data$Date),format="%d/%m/%Y")

# now get the subset of the data we care about
theDay <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

# Open the file, generate the histogram, close the file
png('plot1.png')
hist(theDay$Global_active_power, col='red', 
        xlab="Global Active Power (kilowatts)",
        main="Global Active Power")
dev.off()

