household_power_consumption <- read.csv("~/household_power_consumption.txt", sep=";", header = TRUE)
house <- household_power_consumption[household_power_consumption$Date == "1/2/2007" , ]
house2 <- household_power_consumption[household_power_consumption$Date == "2/2/2007", ]
merge_house = rbind(house, house2)
merge_house$Datetime <- with(merge_house, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

attach(merge_house)
par(mfrow=c(2,2))
plot(merge_house$Datetime, merge_house$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(merge_house$Datetime, merge_house$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(merge_house$Sub_metering_3 ~ merge_house$Datetime, data = merge_house, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "blue", ylim = c(0, 40))
lines(merge_house$Datetime, merge_house$Sub_metering_1)
lines(merge_house$Datetime, merge_house$Sub_metering_2, col = "red")
plot(merge_house$Datetime, merge_house$Global_reactive_power, type = "l", xlab = "", ylab = "Global Reactive Power")
