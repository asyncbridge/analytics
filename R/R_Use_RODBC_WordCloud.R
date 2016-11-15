# Use RODBC library.
library(RODBC)
library(NLP)
library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)  

# Connect MySQL DB and encoding is UTF-8.
conn <- odbcConnect(dsn="localhost", uid = "root", pwd = "123456",DBMSencoding="UTF-8")

# Query a table data.
data <- sqlQuery(conn, "SELECT * FROM tbl_fruits")

# Create a data.frame data from the query data.
res <- data.frame(fruits=c(names(summary(data$name))), num_of_fruits=c(summary(data$name)))

# Convert all strings to uppercase.
res$fruits <- toupper(res$fruits)

# Set a random seed
set.seed(1)

# Display a wordcloud from MySQL data.
wordcloud(words=res$fruits, freq=res$num_of_fruits, min.freq = 1, max.words = 200, random.order = FALSE, rot.per = 0.3,colors=brewer.pal(8, "Dark2"))

# Disconnect MySQL connection.
odbcClose(conn)