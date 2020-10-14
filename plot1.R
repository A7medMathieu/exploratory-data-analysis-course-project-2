source("download.R")
ageTotal<-aggregate(Emissions~year,NEI,sum)
with(ageTotal,barplot(height = Emissions/1000,xlab = "year",
                      main = expression('Annual Emission PM'[2.5]*' from 1999 to 2008')
                      ,ylab =expression('PM'[2.5]*' in Kilotons'),
                      names.arg = year,
                      col=factor(year)))
dev.copy(png,"plot1.png",,width=480,height=480);dev.off()