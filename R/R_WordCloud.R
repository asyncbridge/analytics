# Install wordcloud package and related packages.
install.packages('tm')
install.packages('SnowballC')
install.packages('wordcloud')
install.packages('RColorBrewer')

# Use the packages.
library(NLP)
library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)  

# Read text data and use tm. tm is for text mining in R.
text <- readLines("C:\\R_WordCloud_TextData.txt")
docs <- Corpus(VectorSource(text))

# Transform the text data about as follows. 
# Converting as uppercase, removing numbers/punctuations/stopwords/whitespace, stemming the text data
docs <- tm_map(docs, content_transformer(toupper))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, stemDocument)

# Convert the text data to a matrix.
docu_matrix <- TermDocumentMatrix(docs, control=list(tolower=FALSE))
docu_matrix <- as.matrix(docu_matrix)

# Sort the matrix data according to rowsums as desc order.
terms <- sort(rowSums(docu_matrix), decreasing = TRUE)

# Convert the matrix data to data.frame.
terms <- data.frame(word = names(terms), freq=terms)

# Extract 15 items from head.
head(terms, 15)

# Set a random seed.
set.seed(1)

# Display a wordcloud.
wordcloud(words=terms$word, freq=terms$freq, min.freq = 2, max.words = 200, random.order = FALSE, rot.per = 0.3,colors=brewer.pal(8, "Dark2"))