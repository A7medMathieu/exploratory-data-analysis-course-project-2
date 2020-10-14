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