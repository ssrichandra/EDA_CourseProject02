
#------------------------------------------------------------------------------------------------------
#*Q3*: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
        #which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
        #Which have seen increases in emissions from 1999-2008? 

        #Use the ggplot2 plotting system to make a plot answer this question

#------------------------------------------------------------------------------------------------------

#Open Libraries
library(plyr)
library(ggplot2)

#Open the Data File

summ_data <- readRDS("./data/summarySCC_PM25.rds")
class_data <- readRDS("./data/Source_Classification_Code.rds")


#Create the table for the plot, sum of Emissions column by year, by fips

        plot3_data <- ddply(summ_data,c("year","fips","type"),summarize, TotalEmissions_tonnes = sum(Emissions))
        
        plot3_data_md <- subset(plot3_data,plot3_data$fips == "24510")

        #Change the Year to Factor (currently integer)

                plot3_data_md$year <- as.factor(plot3_data_md$year)

#format the output file, save into plots subfolder (not must exist!)

        png(filename = "./plots/Plot3.png")
        
        par(mar=c(3,4,1,1))


#Create the plot,  - Bar Chart Total Emissions all Sources by Type - Baltimore City
        ggplot(data=plot3_data_md,aes(x=year, y=TotalEmissions_tonnes, group=type, colour = type))+
                geom_line(size=1)+
                geom_point(size=5)+
                scale_color_manual(values=c("#b2b2f0","#4d4ddb","#00008f","#00005c"),name="Type")+
                xlab("Year") + ylab("Total Emissions (Tonnes)")+
                ggtitle("Total PM2.5 Emissions by Type, Baltimore City, MD")
        dev.off()