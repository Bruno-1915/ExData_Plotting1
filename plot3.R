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
data[7] <- as.numeric(data[,7])
data[8] <- as.numeric(data[,8])
data[9] <- as.numeric(data[,9])
plot.new()
with(data, plot(Sub_metering_1 ~ date_time, type = 'l', xlab = '',
                ylab = 'Energy sub metering'))
with(data, lines(Sub_metering_2 ~ date_time, type = 'l', col = 'red'))
with(data, lines(Sub_metering_3 ~ date_time, type = 'l', col = 'blue'))
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2',
                              'Sub_metering_3'), col = c('black', 'red', 'blue'),
       lty = c(1, 1, 1))
dev.print(device = png, width = 480, height = 480, file = 'plot3.png')
