source("download.R")
ageTotal<-with(NEI,subset(NEI,fips == "24510"))
ageTotal<-aggregate(Emissions~year,ageTotal,sum)
with(ageTotal,barplot(height = Emissions/1000,xlab = "year",
                      main = expression('Baltimore, Maryland Emissions from 1999 to 2008')
                      ,ylab =expression('PM'[2.5]*' in Kilotons'),
                      names.arg = year,
                      col=factor(year)))
dev.copy(png,"plot2.png",width=480,height=480);dev.off()