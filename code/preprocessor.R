# The CGM data was downloaded from https://doi.org/10.1371/journal.pbio.2005143.s010. 
# The unzipped file was stored under '/data' directory in the current repository.
# This script pre-process the file to a csv format and saved it under the same '/data' folder.

# Author: David Buchanan
# Date: January 31st, 2020, edited June 14th, 2020 by Elizabeth Chun, edited May 14th, 2022 by Yixing Lu

# Set the working directory to the folder where the original data file is stored
data_dir = paste(dirname(getwd()),'data',sep='/')
setwd(data_dir)

# Here we list the filename for the data exactly as downloaded. 
filename <- "pbio.2005143.s010" 

# Read the raw data in
curr = read.table(filename, header = TRUE, sep = "\t")

# Reorder and trim the columns to follow format
curr = curr[c(3,1,2)] 

# Renaming the columns the standard format names
colnames(curr) = c("id","time","gl")

# Ensure glucose values are recorded as numeric
curr$gl = as.numeric(as.character(curr$gl))

# Reformat the time to standard
curr$"time" = as.POSIXct(curr$time, format="%Y-%m-%d %H:%M:%S") 

# Save the cleaned data to same folder that the raw data file is in
# The cleaned file will be named "dataset"_processed.csv
write.table(curr, file = 'CGM_processed.csv', 
            row.names=F, col.names = !file.exists('CGM_processed.csv'),
            append = T, sep = ",")