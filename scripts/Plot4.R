
#------------------------------------------------------------------------------------------------------
#*Q4*: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008? 

#------------------------------------------------------------------------------------------------------

#Open Libraries
library(plyr)
library(ggplot2)

#Open the Data File

summ_data <- readRDS("./data/summarySCC_PM25.rds")
class_data <- readRDS("./data/Source_Classification_Code.rds")

#Subset the Classification table to only include the Combustion string in the SCC Level One column, and 
#Coal string in the SCC Level Three Column

        coalcombsources <- subset(class_data,grepl("Combustion",class_data[[7]]) & grepl("Coal",class_data[[9]]))

#Join the table to the summ data by SCC code

        mdata <- merge(summ_data,coalcombsources,by.x="SCC", by.y="SCC")

#Create the table for the plot, sum of Emissions column by year, by fips

plot4_data <- ddply(mdata,c("year"),summarize, TotalEmissions_kilotonnes = sum(Emissions)/1000)

plot4_data$year <- as.factor(plot4_data$year)

#format the output file, save into plots subfolder (not must exist!)

png(filename = "./plots/Plot4.png")

par(mar=c(3,4,1,1))


#Create the plot,  - Bar Chart Total Emissions by Coal Combustion
ggplot(data=plot4_data,aes(x=year, y=TotalEmissions_kilotonnes))+
        geom_bar(colour="#3399ff", fill="#3399ff", stat="identity")+
        xlab("Year") + ylab("Total Emissions (kiloTonnes)")+
        ggtitle("Total PM2.5 Emissions by Coal Combustion")


dev.off()