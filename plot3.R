# We only need the data between 1/2/2007 and 2/2/2007 and the data is ordered on Date
# So I use shell to get the start line number and the total lines I should read
# Below is my shell script:
# grep -rHn "1/2/2007" household_power_consumption.txt|more --> I got the start line is 66638
# grep -rHn "3/2/2007" household_power_consumption.txt|more --> I got the end line is 69518 -1 = 69517
# (Where 69518 is the start line for 3/2/2007)
# The total lines number should be 69517-66638+1 = 2880
# And I should skip 66638-1 = 66637 lines
mydata<-read.table('household_power_consumption.txt', sep=";", colClasses=c("character", "character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"), skip=66637, nrows=2880)

s<-c("Date", "Time", "Global_active_power (killowatts)", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colnames(mydata)<-s

x<-sprintf("%s %s", mydata$Date, mydata$Time)
d<-as.POSIXlt(x, format="%d/%m/%Y %H:%M:%S")

png(file="plot3.png")
plot(d, mydata$Sub_metering_3, type="l", xlab="", ylab="Energy sub metering", col="blue")
plot(d, mydata$Sub_metering_2, type="l", xlab="", ylab="Energy sub metering", col="red")
plot(d, mydata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(d, mydata$Sub_metering_1)
lines(d, mydata$Sub_metering_2, col="red")
lines(d, mydata$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
