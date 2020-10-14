Exploratory Data Analysis - Course Project 2
============================================

**NOTE: My work and answers to the questions are at the bottom of this document.**

# Introduction

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National [Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html).

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

# Data

The data for this assignment are available from the course web site as a single zip file:

* [Data for Peer Assessment [29Mb]](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

The zip file contains two files:

PM2.5 Emissions Data (`summarySCC_PM25.rds`): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.
````
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
````

* `fips`: A five-digit number (represented as a string) indicating the U.S. county
* `SCC`: The name of the source as indicated by a digit string (see source code classification table)
* `Pollutant`: A string indicating the pollutant
* `Emissions`: Amount of PM2.5 emitted, in tons
* `type`: The type of source (point, non-point, on-road, or non-road)
* `year`: The year of emissions recorded

Source Classification Code Table (`Source_Classification_Code.rds`): This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the `readRDS()` function in R. For example, reading in each file can be done with the following code:

````
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
````

as long as each of those files is in your current working directory (check by calling `dir()` and see if those files are in the listing).

# Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.

## Making and Submitting Plots

For each plot you should

* Construct the plot and save it to a PNG file.
* Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)
* Upload the PNG file on the Assignment submission page
* Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.

In preparation we first ensure the data sets archive is downloaded and extracted.

```{r setup,echo=FALSE}
# Download archive file, if it does not exist
if(!(file.exists("summarySCC_PM25.rds") &&
     file.exists("Source_Classification_Code.rds"))){
  if(!file.exists("NEI_data.zip")) {
    
    archiveURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    
    download.file(url=archiveURL,destfile="NEI_data.zip")
  }
  unzip("NEI_data.zip")
}
if (!exists("NEI")) {
  # print("Loading NEI Data, please wait.")
  NEI <- readRDS("summarySCC_PM25.rds") 
}

if (!exists("SCC")) {
  # print("Loading SCC Data.")
  SCC <- readRDS("Source_Classification_Code.rds")
}
```


## Questions

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

### Question 1

First we'll aggregate the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.Using the base plotting system, now we plot the total PM2.5 Emission from all sources,

```{r plot1}
source("download.R")
ageTotal<-aggregate(Emissions~year,NEI,sum)
with(ageTotal,barplot(height = Emissions/1000,xlab = "year",
                      main = expression('Annual Emission PM'[2.5]*' from 1999 to 2008')
                      ,ylab =expression('PM'[2.5]*' in Kilotons'),
                      names.arg = year,
                      col=factor(year)))
dev.copy(png,"plot1.png",,width=480,height=480);dev.off()
```
**Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?**

As we can see from the plot, total emissions have decreased in the US from 1999 to 2008.

![plot of plot1.png](./plot1.png)

### Question 2

First we aggregate total emissions from PM2.5 for Baltimore City, Maryland (fips="24510") from 1999 to 2008.

```
source("download.R")
ageTotal<-with(NEI,subset(NEI,fips == "24510"))
ageTotal<-aggregate(Emissions~year,ageTotal,sum)
```

Now we use the base plotting system to make a plot of this data,

```{r plot2}

with(ageTotal,barplot(height = Emissions/1000,xlab = "year",
                      main = expression('Baltimore, Maryland Emissions from 1999 to 2008')
                      ,ylab =expression('PM'[2.5]*' in Kilotons'),
                      names.arg = year,
                      col=factor(year)))
dev.copy(png,"plot2.png",width=480,height=480);dev.off()
```

**Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?**

Overall total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008.

![plot of plot2.png](./plot2.png)

### Question 3

Using the ggplot2 plotting system,

```{r plot3}
source("download.R")
ageTotal<-with(NEI,subset(NEI,fips == "24510"))
library(ggplot2)
ggp <- ggplot(ageTotal,aes(factor(year),Emissions,fill=type))+
  geom_bar(stat="identity") +
  facet_grid(.~type) + 
  labs(x="year", y=expression("PM"[2.5]*" Emission")) + 
  labs(title="Baltimore City 1999-2008 by Source Type")
ggp
dev.copy(png,"plot3.png",width=580,height=580);dev.off()
```

**Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?**

The `non-road`, `nonpoint`, `on-road` source types have all seen decreased emissions overall from 1999-2008 in Baltimore City.

**Which have seen increases in emissions from 1999–2008?**

The `point` source saw a slight increase overall from 1999-2008. Also note that the `point` source saw a significant increase until 2005 at which point it decreases again by 2008 to just above the starting values. 

![plot of plot3.png](./plot3.png)

### Question 4

First we subset coal combustion source factors NEI data.

```{r combustion,cache=TRUE}
source("download.R")
require(dplyr)
colSCC<-SCC[grep("[Cc][Oo][Aa][Ll]",SCC$EI.Sector),"SCC"]
coalNEI<-NEI%>%filter(SCC %in% colSCC)
coalSummary<-coalNEI%>%group_by(year)%>%summarise(Emissions = sum(Emissions))
```

Note:  The SCC levels go from generic to specific. We assume that coal combustion related SCC records are those where SCC.Level.One contains the substring 'comb' and SCC.Level.Four contains the substring 'coal'.

```{r plot4}
require(ggplot2)
c_plot<-ggplot(coalSummary,aes(factor(year),round(Emissions/1000,2),
                              label=round(Emissions/1000,2),fill=year))+
  geom_bar(stat="identity")+ ylab(expression('PM'[2.5]*' Emissions in Kilotons')) +
  xlab("Year") +geom_label(aes(fill=year),color="white",fontface="bold")+
  ggtitle("Coal Combustion Emissions, 1999 to 2008.")
c_plot
dev.copy(png,"plot4.png",width=480,height=480);dev.off()
```

**Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?**

Emissions from coal combustion related sources have decreased from 6 * 10^6 to below 4 * 10^6 from 1999-2008.

Eg. Emissions from coal combustion related sources have decreased by about 1/3 from 1999-2008!

![plot of plot4.png](./plot4.png)

### Question 5

First we subset the motor vehicles, which we assume is anything like Motor Vehicle in SCC.Level.Two.
Next we subset for motor vehicles in Baltimore,

```{r motorVehicles,cache=TRUE}
require(dplyr)
scc_vec<-SCC[grep("[Vv]ehicle",SCC$EI.Sector),"SCC"]
vecNEI<-NEI%>%filter(SCC %in% scc_vec&fips=="24510")%>%
      group_by(year)%>%
      summarise(Emissions=sum(Emissions))
```


Finally we plot using ggplot2,

```{r plot5}
require(ggplot2)
v_plot <- ggplot(vecNEI, aes(x=factor(year), y=Emissions, label=round(Emissions,2), fill=year)) +
  geom_bar(stat="identity") + ylab(expression('PM'[2.5]*' Emissions in tons')) + xlab("Year") +
  geom_label(aes(fill = year),colour = "white", fontface = "bold") +
  ggtitle("Emissions from motor vehicle sources in Baltimore City.")
v_plot

dev.copy(png,"plot5.png",width=480,height=480);dev.off()
```
![plot of plot5.png](./plot5.png)

**How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?**

Emissions from motor vehicle sources have dropped from 1999-2008 in Baltimore City!

### Question 6

Comparing emissions from motor vehicle sources in Baltimore City (fips == "24510") with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"),

```{r mvBaltimoreLA,cache=TRUE}
source("download.R")
require(dplyr)
fips_lookup <- data.frame(fips = c("06037", "24510"), county = c("Los Angeles", "Baltimore"))
scc_vec<-SCC[grep("[Vv]ehicle",SCC$EI.Sector),"SCC"]
vecNEI<-NEI%>%filter(SCC %in% scc_vec&fips%in%fips_lookup$fips)%>%
  group_by(year,fips)%>%
  summarise(Emissions=sum(Emissions))
vecNEI<-merge(vecNEI,fips_lookup)
```

Now we plot using the ggplot2 system,

```{r plot6}
require(ggplot2)
v_plot <- ggplot(vecNEI, aes(x=factor(year), y=Emissions,
                             label=round(Emissions,2), fill=county)) +
  geom_bar(stat="identity") + ylab(expression('PM'[2.5]*' Emissions in tons')) + xlab("Year") +
  geom_label(aes(fill = county),colour = "white", fontface = "bold") +
  ggtitle("Los Angeles vs Baltimore Vehicle Emissions.")+
  facet_grid(.~county,scales = "free")
v_plot

dev.copy(png,"plot6.png",width=480,height=480);dev.off()
```

**Which city has seen greater changes over time in motor vehicle emissions?**

Los Angeles County has seen the greatest changes over time in motor vehicle emissions.

![plot of plot6.png](./plot6.png)
