household_power_consumption <- read.csv("~/household_power_consumption.txt", sep=";", header = TRUE)
house <- household_power_consumption[household_power_consumption$Date == "1/2/2007" , ]
house2 <- household_power_consumption[household_power_consumption$Date == "2/2/2007", ]
merge_house = rbind(house, house2)
merge_house$Datetime <- with(merge_house, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))


hist(as.numeric(as.character(merge_house$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
