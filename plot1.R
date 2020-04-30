#Load data.table Library for fread 
library(data.table)

#Reading the file , define NA by ?, define colums Type
data <- fread("household_power_consumption.txt",na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#Convert Date column as Date Type 
data$Date <- as.Date(data$Date, "%d/%m/%Y")
#Subset the selected data 
selected <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

#Plot the graph
hist(selected$Global_active_power,col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
#Save The File 
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()