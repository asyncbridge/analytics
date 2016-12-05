# Install wordcloud package and related packages.
#install.packages('KoNLP') # For Korean
#install.packages('SnowballC')
#install.packages('wordcloud')
#install.packages('RColorBrewer')
#install.packages('plyr') 

library(KoNLP)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)  
library(plyr) 

# Use Korean dictionary.
useSejongDic()

# Read text data from text file.
text <- readLines("R_WordCloud_KRTextData.txt")
parsed <- sapply(text,extractNoun,USE.NAMES = F)

# Transform the text data about as follows. 
# Remove some characters.
parsed <- unlist(parsed) 
parsed <- gsub("\\d+", "", parsed)
parsed <- gsub("\\(", "", parsed)
parsed <- gsub("\\)", "", parsed)
parsed <- gsub("\\.", "", parsed)
parsed <- gsub("\\:", "", parsed)
parsed <- gsub("[A-Za-z]", "", parsed)
parsed <- Filter(function(x) {nchar(x) >= 2}, parsed)

# Store parsed text to txt file to read it as table.
write(unlist(parsed), "kr_cloud.txt")
text_table <- read.table("kr_cloud.txt")

# Create table data with word count
word_Count <- table(text_table)

# Create data.frame from table data.
terms <- data.frame(word_Count)

# Change column name.
names(terms) <- c("word", "freq") 

# Sort the matrix data according to rowsums as desc order.
terms <- arrange(terms, desc(freq))

# Extract 15 items from head top 15.
#top15 <- head(terms, 200)

# Set a random seed.
set.seed(1)

# Display a wordcloud.
#wordcloud(words=top15$word, freq=top15$freq, min.freq = 2, max.words = 500, random.order = FALSE, rot.per = 0.3,colors=brewer.pal(8, "Dark2"))
wordcloud(words=terms$word, freq=terms$freq, min.freq = 1, max.words = 500, random.order = FALSE, rot.per = 0.3,colors=brewer.pal(8, "Dark2"))