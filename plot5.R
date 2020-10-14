source("download.R")
require(dplyr)
scc_vec<-SCC[grep("[Vv]ehicle",SCC$EI.Sector),"SCC"]
vecNEI<-NEI%>%filter(SCC %in% scc_vec&fips=="24510")%>%
      group_by(year)%>%
      summarise(Emissions=sum(Emissions))
require(ggplot2)
v_plot <- ggplot(vecNEI, aes(x=factor(year), y=Emissions, label=round(Emissions,2), fill=year)) +
  geom_bar(stat="identity") + ylab(expression('PM'[2.5]*' Emissions in tons')) + xlab("Year") +
  geom_label(aes(fill = year),colour = "white", fontface = "bold") +
  ggtitle("Emissions from motor vehicle sources in Baltimore City.")
v_plot

dev.copy(png,"plot5.png",width=480,height=480);dev.off()
