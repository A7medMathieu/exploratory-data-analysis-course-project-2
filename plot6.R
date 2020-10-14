source("download.R")
require(dplyr)
fips_lookup <- data.frame(fips = c("06037", "24510"), county = c("Los Angeles", "Baltimore"))
scc_vec<-SCC[grep("[Vv]ehicle",SCC$EI.Sector),"SCC"]
vecNEI<-NEI%>%filter(SCC %in% scc_vec&fips%in%fips_lookup$fips)%>%
  group_by(year,fips)%>%
  summarise(Emissions=sum(Emissions))
vecNEI<-merge(vecNEI,fips_lookup)
require(ggplot2)
v_plot <- ggplot(vecNEI, aes(x=factor(year), y=Emissions,
                             label=round(Emissions,2), fill=county)) +
  geom_bar(stat="identity") + ylab(expression('PM'[2.5]*' Emissions in tons')) + xlab("Year") +
  geom_label(aes(fill = county),colour = "white", fontface = "bold") +
  ggtitle("Los Angeles vs Baltimore Vehicle Emissions.")+
  facet_grid(.~county,scales = "free")
v_plot

dev.copy(png,"plot6.png",width=480,height=480);dev.off()
