
#------------------------------------------------------------------------------------------------------
#*Q2*: Have total emissions from PM2.5 decreased in the Baltimore City, 
        #Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
        #to make a plot answering this question

#------------------------------------------------------------------------------------------------------

#Open Libraries
library(plyr)


#Open the Data File

        summ_data <- readRDS("./data/summarySCC_PM25.rds")
        class_data <- readRDS("./data/Source_Classification_Code.rds")


#Create the table for the plot, sum of Emissions column by year, by fips

        plot2_data <- ddply(summ_data,c("year","fips"),summarize, TotalEmissions_kilotonnes = sum(Emissions)/1000)
        
        plot2_data_md <- subset(plot2_data,plot2_data$fips == "24510")

#format the output file, save into plots subfolder (not must exist!)

        png(filename = "./plots/Plot2.png")
        
        par(mar=c(3,4,3,1))


#Create the plot,  - Bar Chart Total Emissions all Sources for Baltimore City
        barplot(plot2_data_md$TotalEmissions_kilotonnes, 
                main = "Total PM2.5 Emissions - All Sources\nBaltimore City, MD", 
                xlab = "Year", 
                ylab = "Emissions (kiloTonnes)", 
                col = "#0066ff", 
                names.arg=plot2_data_md$year)
        
        dev.off()