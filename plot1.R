# We only need the data between 1/2/2007 and 2/2/2007 and the data is ordered on Date
# So I use shell to get the start line number and the total lines I should read
# Below is my shell script:
# grep -rHn "1/2/2007" household_power_consumption.txt|more --> I got the start line is 66638
# grep -rHn "3/2/2007" household_power_consumption.txt|more --> I got the end line is 69518 -1 = 69517
# (Where 69518 is the start line for 3/2/2007)
# The total lines number should be 69517-66638+1 = 2880
# And I should skip 66638-1 = 66637 lines
mydata<-read.table('household_power_consumption.txt', sep=";", colClasses=c("character", "character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"), skip=66637, nrows=2880)

colnames(mydata)=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")


png(file="plot1.png")
hist(mydata$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
