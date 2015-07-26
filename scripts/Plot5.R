
#------------------------------------------------------------------------------------------------------
#*Q5*: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

#------------------------------------------------------------------------------------------------------

#Open Libraries
library(plyr)
library(ggplot2)

#Open the Data File

summ_data <- readRDS("./data/summarySCC_PM25.rds")
class_data <- readRDS("./data/Source_Classification_Code.rds")

#Subset the Classification table to only include the Combustion string in the SCC Level One column, and 
#Coal string in the SCC Level Three Column

gasvehicles <- subset(class_data,grepl("Gasoline Vehicles",class_data[[9]]))

#Join the table to the summ data by SCC code

vehdata <- merge(summ_data,gasvehicles,by.x="SCC", by.y="SCC")

#Create the table for the plot, sum of Emissions column by year, by fips

plot5_data <- ddply(vehdata,c("year","fips"),summarize, TotalEmissions_tonnes = sum(Emissions))

plot5_data_md <- subset(plot5_data,plot5_data$fips == "24510")


plot5_data_md$year <- as.factor(plot5_data_md$year)

#format the output file, save into plots subfolder (not must exist!)

png(filename = "./plots/Plot5.png")

par(mar=c(3,4,1,1))


#Create the plot,  - Bar Chart Total Vehicle Emissions - Baltimore City
ggplot(data=plot5_data_md,aes(x=year, y=TotalEmissions_tonnes))+
        geom_bar(colour="#4DB8ff", fill="#4DB8ff", stat="identity")+
        xlab("Year") + ylab("Total Emissions (Tonnes)")+
        ggtitle("Total PM2.5 Emissions by Motor Vehicles\nBaltimore City, MD")

dev.off()