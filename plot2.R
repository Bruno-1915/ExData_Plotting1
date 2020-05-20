library(dplyr)

data_path <- 'exdata_data_household_power_consumption/household_power_consumption.txt'
data <- read.table(data_path, sep = ';', stringsAsFactors = FALSE)
data <- data[data[,1] == '1/2/2007' | data[,1] == '2/2/2007',]
labels <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power',
            'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2',
            'Sub_metering_3')
names(data) <- labels
data$date_time <- paste0(data$Date," ",data$Time)
data <- data %>% 
        mutate(date_time = as.POSIXct(data$date_time, format = "%d/%m/%Y %H:%M:%S"))
data[3] <- as.numeric(data[,3])
with(data, plot(Global_active_power ~ date_time, type = 'l', xlab = '',
                ylab = 'Global Active Power (kilowatts)'))
dev.print(device = png, width = 480, height = 480, file = 'plot2.png')

