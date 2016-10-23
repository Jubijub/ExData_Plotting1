##### COMMON BOILERPLATE FOR ALL FILES #####

## Downloading the source data
rawDataSource <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "./household_power_consumption.zip"

if (!file.exists(zipFile)){download.file(rawDataSource, zipFile)}
message("Source File downloaded")
if(file.exists(zipFile)){unzip(zipfile=zipFile, exdir=".")}
message("ZIP content extracted")

## Reading the data into a dataframe
# As per the exercise parameters, load only lines between 2007-02-1 and 2007-02-02
hpc <- read.table("./household_power_consumption.txt", 
                  header = TRUE,
                  sep = ";",
                  skip=66636,
                  nrow=69517-66637)
# Setting names manually as skip removes the head line
names(hpc) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2", "Sub_metering_3")

# Converting dates to proper dates
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
hpc$DateTime <- as.POSIXct(paste(hpc$Date,hpc$Time))
message("Household power consumption data loaded and cleaned")

###################################################
#Forces local to English so that data labels are in English
Sys.setlocale(category = "LC_ALL", locale = "english")

# Produce the PNG file
png("plot2.png", width = 480, height = 480)
with(hpc, plot(DateTime, Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
message("plot2.png file created")