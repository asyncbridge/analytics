# Use RODBC library.
library(RODBC)
library(NLP)

# Use ggplot2 library.
library(ggplot2) 
library(plyr) 

# Connect MySQL DB and encoding is UTF-8.
conn <- odbcConnect(dsn="localhost", uid = "root", pwd = "123456",DBMSencoding="UTF-8")

# Query a table data.
data <- sqlQuery(conn, "SELECT * FROM tbl_fruits")

# Create a data.frame data from the query data.
res <- data.frame(fruits=c(names(summary(data$name))), num_of_fruits=c(summary(data$name)))

# Sort the data.frame data as desc order of the number of fruits.
res <- arrange(res, desc(num_of_fruits))

# Get top 5 record from head.
res_top5 <- head(res, 5)

# Use ggplot and display bar graph.
ggplot(data=res_top5, aes(x=fruits, y=num_of_fruits, group=1)) + geom_bar(stat="identity", aes(fill=fruits), position=position_dodge(), colour="black")  + theme(legend.position="right", legend.direction="vertical") + geom_text(data=res_top5, aes(label=res_top5$num_of_fruits), position=position_identity(), vjust=1.5)

# Disconnect MySQL connection.
odbcClose(conn)