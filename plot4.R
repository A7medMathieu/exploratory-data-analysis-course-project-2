source("download.R")
require(dplyr)
colSCC<-SCC[grep("[Cc][Oo][Aa][Ll]",SCC$EI.Sector),"SCC"]
coalNEI<-NEI%>%filter(SCC %in% colSCC)
coalSummary<-coalNEI%>%group_by(year)%>%summarise(Emissions = sum(Emissions))
require(ggplot2)
c_plot<-ggplot(coalSummary,aes(factor(year),round(Emissions/1000,2),
                              label=round(Emissions/1000,2),fill=year))+
  geom_bar(stat="identity")+ ylab(expression('PM'[2.5]*' Emissions in Kilotons')) +
  xlab("Year") +geom_label(aes(fill=year),color="white",fontface="bold")+
  ggtitle("Coal Combustion Emissions, 1999 to 2008.")
c_plot
dev.copy(png,"plot4.png",width=480,height=480);dev.off()