# Script for creating plot 4


## Obtains the data for the plot
getData<-function()
{
  data.path <- "./ExData_Plotting1_Data"  
  zipfile.url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipfile.file <- paste0(data.path, "/household_power_consumption.zip")
  data.file <-paste0(data.path, "/household_power_consumption.txt" )
  first.line <- 66638
  last.line <- 69518
  data.features <-  c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
  
  if (!file.exists(data.path)) {
    dir.create(data.path)
    download.file(url = zipfile.url, destfile = zipfile.file)
    unzip (zipfile.file, exdir = data.path)
  }  
  
  df <- read.csv(data.file, skip =first.line-1, nrows = last.line-first.line , header = FALSE, sep = ";", col.names = data.features)
  Sys.setlocale("LC_TIME", "C"); ## To show  weekdays in English
  df$moment <- strptime(paste(df$Date, df$Time, sep=" ") ,format = "%d/%m/%Y %H:%M:%S" )
  df
}



## Draws the plot into a file
plot4 <- function(df, plot.name) {
  png(filename = plot.name)
  par(mfrow=c(2,2))
  
  #plot1
  plot(df$moment,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)") 
  #plot2
  plot(df$moment, df$Voltage, type="l", xlab="datetime", ylab="Voltage")
  #plot3
  plot(df$moment,df$Sub_metering_1, type="l",col="Black", xlab="", ylab="Energy sub metering")
  lines(df$moment,df$Sub_metering_2, col="Red")
  lines(df$moment,df$Sub_metering_3, col="Blue")
  legend("topright", lty=c(1,1), col=c("Black", "Red","Blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
  #plot4
  plot(df$moment, df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  dev.off()
}

plot4 (getData(), "plot4.png")  




