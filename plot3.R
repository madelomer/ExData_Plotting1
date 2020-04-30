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
with(selected,{ plot(selected$Sub_metering_1~selected$DateTime , type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(selected$Sub_metering_2~selected$DateTime ,col="Red" ) 
  lines(selected$Sub_metering_3~selected$DateTime ,col="Blue" )
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Save The File 
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()