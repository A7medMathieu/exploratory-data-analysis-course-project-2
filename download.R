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

