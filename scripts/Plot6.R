
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

plot6_data <- ddply(vehdata,c("year","fips"),summarize, TotalEmissions_tonnes = sum(Emissions))

plot6_data_mdvla <- subset(plot5_data,plot5_data$fips == "24510" | plot5_data$fips == "06037")

        #Change the Year to Factor (currently integer)
        
        plot6_data_mdvla$year <- as.factor(plot6_data_mdvla$year)

#format the output file, save into plots subfolder (not must exist!)

png(filename = "./plots/Plot6.png")

par(mar=c(3,4,1,1))


#Create the plot,  - Bar Chart Total Vehicle Emissions - Baltimore City vs LA County
ggplot(data=plot6_data_mdvla,aes(x=year, y=TotalEmissions_tonnes, fill=fips))+
        geom_bar(stat="identity", position=position_dodge())+
        scale_fill_manual(values=c("#99CCFF","#2B2B7D"), name="FIPS/City",labels=c("LA County","Baltimore City"))+
        xlab("Type") + ylab("Total Emissions (Tonnes)")+
        ggtitle("Total Vehicle PM2.5 Emissions\nBaltimore City, MD vs LA County, CA")
dev.off()
