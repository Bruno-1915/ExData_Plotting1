library(dplyr)

data_path <- 'exdata_data_household_power_consumption/household_power_consumption.txt'
data <- read.table(data_path, sep = ';', stringsAsFactors = FALSE)
data <- data[data[,1] == '1/2/2007' | data[,1] == '2/2/2007',]
labels <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power',
            'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2',
            'Sub_metering_3')
names(data) <- labels
data <- mutate(data, Date = as.Date(Date, format = '%d/%m/%Y'))
data[[3]] <- as.numeric(data[,3])

hist(data$Global_active_power, col = 'red', 
     xlab = 'Global Active Power (kilowats)', main = 'Global Active Power')
dev.print(device = png, width = 480, height = 480, file = 'plot1.png')
              
