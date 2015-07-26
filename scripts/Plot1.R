
#------------------------------------------------------------------------------------------------------
#*Q1*: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
        #Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
        #for each of the years 1999, 2002, 2005, and 2008.

#------------------------------------------------------------------------------------------------------

#Open Libraries
library(plyr)


#Open the Data File

        summ_data <- readRDS("./data/summarySCC_PM25.rds")
        class_data <- readRDS("./data/Source_Classification_Code.rds")


#Create the table for the plot, sum of Emissions column by year

        plot1_data <- ddply(summ_data,"year",summarize, TotalEmissions_miltonnes = sum(Emissions)/1000000)

#format the output file, save into plots subfolder (not must exist!)

        png(filename = "./plots/Plot1.png")
        
        par(mar=c(3,4,1,1))


#Create the plot,  - Bar Chart Total Emissions all Sources by Year
        barplot(plot1_data$TotalEmissions_miltonnes, 
                main = "Total PM2.5 Emissions - All Sources", 
                xlab = "Year", 
                ylab = "Emissions (mil. Tonnes)", 
                col = "#30307b", 
                names.arg=plot1_data$year)
        
        dev.off()