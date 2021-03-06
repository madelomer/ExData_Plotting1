#Load data.table Library for fread 
library(data.table)

#Reading the file , define NA by ?, define colums Type
data <- fread("household_power_consumption.txt",na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#Convert Date column as Date Type 
data$Date <- as.Date(data$Date, "%d/%m/%Y")
#Subset the selected data 
selected <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

#Create DateTime Colum by combine the date and time cloumns  
DateTime <- paste(selected$Date , selected$Time,sep = " ")
names(DateTime) <- "DateTime"
selected$Date <- DateTime
#Convet it to POSIXct
selected$DateTime <- as.POSIXct(DateTime)

#Plot the graph
par(mfrow=c(2,2), mar=c(4,4,2,1))

with(selected, {
  
  plot(selected$DateTime, selected$Global_active_power,type = "l", ylab="Global Active Power (kilowatts)",xlab="")
  plot(selected$DateTime, selected$Voltage,type = "l", ylab="Voltage (volt)",xlab="")
  plot(selected$Sub_metering_1~selected$DateTime , type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(selected$Sub_metering_2~selected$DateTime ,col="Red" ) 
  lines(selected$Sub_metering_3~selected$DateTime ,col="Blue" )
  plot(selected$DateTime, selected$Global_reactive_power,type = "l",ylab="Global Rective Power (kilowatts)",xlab="")
  
})
#Save The File 
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()