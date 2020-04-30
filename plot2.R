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
plot(selected$DateTime, selected$Global_active_power,type="l", ylab="Global Active Power (kilowatts)", xlab="")
#Save The File 
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()