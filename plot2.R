


## 
## "plot2.R"
##
## Plots power consumption over 2 days in February 2007 (02/01/2007 and 
## 02/02/2007), extracted from the “Individual household electric power 
## consumption Data Set” in the UC Irvine Machine Learning Repository.
##


## load the dataset and extract the desired 2 days of data
## [ NOTE: assumes that the downloaded .zip file has been unzipped ]
##
        # read all rows
power_all <- 
 read.table( "household_power_consumption.txt", 
             header = TRUE, 
             sep = ";", 
             na.strings = "?", 
             colClasses = c( "character", "character", rep("numeric", 7) ), 
             nrows = 2075259, 
             stringsAsFactors = FALSE )
names(power_all)
# [1] "Date"                  "Time"                  "Global_active_power"  
# [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
# [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"   
head(power_all)
#         Date     Time Global_active_power Global_reactive_power Voltage Global_intensity
# 1 16/12/2006 17:24:00               4.216                 0.418  234.84             18.4
# 2 16/12/2006 17:25:00               5.360                 0.436  233.63             23.0
# 3 16/12/2006 17:26:00               5.374                 0.498  233.29             23.0
# 4 16/12/2006 17:27:00               5.388                 0.502  233.74             23.0
# 5 16/12/2006 17:28:00               3.666                 0.528  235.68             15.8
# 6 16/12/2006 17:29:00               3.520                 0.522  235.02             15.0
#   Sub_metering_1 Sub_metering_2 Sub_metering_3
# 1              0              1             17
# 2              0              1             16
# 3              0              2             17
# 4              0              1             17
# 5              0              1             17
# 6              0              2             17

        # combine "Date" and "Time" fields into "NewDate" field 
power_all$NewDate <- as.Date(  strptime( paste(power_all$Date, power_all$Time), 
                                         format = "%d/%m/%Y %H:%M:%S" )  
                            ) 
power_all$NewDateTime <- strptime( paste(power_all$Date, power_all$Time), 
                                   format = "%d/%m/%Y %H:%M:%S" ) 
names(power_all)
# [1] "Date"                  "Time"                  "Global_active_power"  
# [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
# [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"       
# [10] "NewDate"               "NewDateTime"    
head(power_all)
#         Date     Time Global_active_power Global_reactive_power Voltage Global_intensity
# 1 16/12/2006 17:24:00               4.216                 0.418  234.84             18.4
# 2 16/12/2006 17:25:00               5.360                 0.436  233.63             23.0
# 3 16/12/2006 17:26:00               5.374                 0.498  233.29             23.0
# 4 16/12/2006 17:27:00               5.388                 0.502  233.74             23.0
# 5 16/12/2006 17:28:00               3.666                 0.528  235.68             15.8
# 6 16/12/2006 17:29:00               3.520                 0.522  235.02             15.0
#   Sub_metering_1 Sub_metering_2 Sub_metering_3    NewDate         NewDateTime
# 1              0              1             17 2006-12-16 2006-12-16 17:24:00
# 2              0              1             16 2006-12-16 2006-12-16 17:25:00
# 3              0              2             17 2006-12-16 2006-12-16 17:26:00
# 4              0              1             17 2006-12-16 2006-12-16 17:27:00
# 5              0              1             17 2006-12-16 2006-12-16 17:28:00
# 6              0              2             17 2006-12-16 2006-12-16 17:29:00
nrow(power_all)
# [1] 2075259
colSums( is.na(power_all) )
# Date                  Time   Global_active_power Global_reactive_power 
#    0                     0                 25979                 25979 
# Voltage      Global_intensity        Sub_metering_1        Sub_metering_2 
#   25979                 25979                 25979                 25979 
# Sub_metering_3               NewDate           NewDateTime 
#          25979                     0                   240

        # extract rows of desired 2 days 
power_2d <- 
 power_all[ ( (as.Date(power_all$NewDateTime) == "2007-02-01") 
               | (as.Date(power_all$NewDateTime) == "2007-02-02") ), ] 
names(power_2d)
# [1] "Date"                  "Time"                  "Global_active_power"  
# [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
# [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"       
# [10] "NewDate"               "NewDateTime"
head(power_2d)
#           Date     Time Global_active_power Global_reactive_power Voltage Global_intensity
# 66637 1/2/2007 00:00:00               0.326                 0.128  243.15              1.4
# 66638 1/2/2007 00:01:00               0.326                 0.130  243.32              1.4
# 66639 1/2/2007 00:02:00               0.324                 0.132  243.51              1.4
# 66640 1/2/2007 00:03:00               0.324                 0.134  243.90              1.4
# 66641 1/2/2007 00:04:00               0.322                 0.130  243.16              1.4
# 66642 1/2/2007 00:05:00               0.320                 0.126  242.29              1.4
#       Sub_metering_1 Sub_metering_2 Sub_metering_3    NewDate         NewDateTime
# 66637              0              0              0 2007-02-01 2007-02-01 00:00:00
# 66638              0              0              0 2007-02-01 2007-02-01 00:01:00
# 66639              0              0              0 2007-02-01 2007-02-01 00:02:00
# 66640              0              0              0 2007-02-01 2007-02-01 00:03:00
# 66641              0              0              0 2007-02-01 2007-02-01 00:04:00
# 66642              0              0              0 2007-02-01 2007-02-01 00:05:00
nrow(power_2d)
# [1] 2880
colSums( is.na(power_2d) )
# Date                  Time   Global_active_power Global_reactive_power 
#    0                     0                     0                     0 
# Voltage      Global_intensity        Sub_metering_1        Sub_metering_2 
#       0                     0                     0                     0 
# Sub_metering_3               NewDate           NewDateTime 
#              0                     0                     0 

        # delete original huge data frame
rm( "power_all" )


## plot global active power and save to PNG file
##
png( "plot2.png", width = 480, height = 480 )
plot( power_2d$NewDateTime, 
      power_2d$Global_active_power, 
      xlab = "", 
      ylab = "Global Active Power (kilowatts)", 
      type = "l" )
dev.off() 


