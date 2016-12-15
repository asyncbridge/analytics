# Install wordcloud package and related packages.
#install.packages('KoNLP') # For Korean
#install.packages('SnowballC')
#install.packages('wordcloud')
#install.packages('RColorBrewer')
#install.packages('plyr') 
#install.packages('stringr')
#install.packages('ggplot2')

library(KoNLP)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)  
library(plyr) 
library(stringr)
library(ggplot2)

# Use Korean dictionary.
useSejongDic()

# Register nouns
mergeUserDic(data.frame("홍길동", "ncn"))
mergeUserDic(data.frame("김철수", "ncn"))
mergeUserDic(data.frame("박영희", "ncn"))

# Read text data from text file.
parsed <- readLines("KakaoTalk_20161216_0049_20_276_group.txt", encoding="UTF-8")

# Apply extract Noun. 
parsed <- sapply(parsed,extractNoun,USE.NAMES = F)

# Unlist and apply filter. Allow only above 2 lengths. 
parsed <- unlist(parsed)
parsed <- Filter(function(x) {nchar(x) >= 2}, parsed)

# Replace specific strings
parsed <- str_replace_all(parsed,"[^[:alpha:]]","")
parsed <- str_replace_all(parsed,"[A-Za-z0-9]","")
parsed <- gsub("음성메세지", "", parsed)
parsed <- gsub("이모티콘", "", parsed)
parsed <- gsub("월요일", "", parsed)
parsed <- gsub("전도사", "", parsed)
parsed <- gsub("화요일", "", parsed)
parsed <- gsub("수요일", "", parsed)
parsed <- gsub("목요일", "", parsed)
parsed <- gsub("금요일", "", parsed)
parsed <- gsub("토요일", "", parsed)
parsed <- gsub("일요일", "", parsed)
parsed <- gsub("날짜", "", parsed)
parsed <- gsub("저장한", "", parsed)
parsed <- gsub("동영상", "", parsed)
parsed <- gsub("사진", "", parsed)
parsed <- gsub("오전", "", parsed)
parsed <- gsub("오후", "", parsed)
parsed <- gsub("누나", "", parsed)
parsed <- gsub("님", "", parsed)
parsed <- gsub("년", "", parsed)          
parsed <- gsub("월", "", parsed)   
parsed <- gsub("일", "", parsed) 
parsed <- gsub("ㅋ", "", parsed)
parsed <- gsub("ㅎ", "", parsed)
parsed <- gsub("ㅇ", "", parsed)
parsed <- gsub("ㅠ", "", parsed)
parsed <- gsub("ㅜ", "", parsed)
parsed <- gsub("아멘", " 아멘", parsed)

# Write parsed string as unlist and read table from the temporary file.
write(unlist(parsed), "kr_cloud_kakao.txt")
text_table <- read.table("kr_cloud_kakao.txt")

# Create table data with word count
word_Count <- table(text_table)

# Create data.frame from table data.
terms <- data.frame(word_Count)

# Change column name.
names(terms) <- c("word", "freq") 

# Sort the matrix data according to rowsums as desc order.
terms <- arrange(terms, desc(freq))

# Extract N items from head top N.
#topN <- head(terms, 200)

# Set a random seed.
set.seed(1)

# Display a wordcloud.
#windowsFonts(myfont=windowsFont("맑은 고딕"))
wordcloud(words=terms$word, freq=terms$freq, min.freq = 0.32, max.words = 400, random.order = FALSE, rot.per = 0.25,colors=brewer.pal(8, "Dark2"), family="AppleGothic")
#wordcloud(words=terms$word, freq=terms$freq, min.freq = 0.32, max.words = 400, random.order = FALSE, rot.per = 0.25,colors=brewer.pal(8, "Dark2"), family="myfont")

# Display a bar chart
#terms2 <- arrange(terms, desc(freq))
#top10 <- head(terms2, 50)
#ggplot(data=top10, aes(x=reorder(word,freq), y=freq, group=1, fill=word)) + geom_bar(stat="identity", aes(fill=word), position=position_dodge(), colour="black")  + theme(legend.position="right", legend.direction="vertical") + coord_flip() + geom_text(data=top10, aes(label=top10$freq), position=position_identity(), vjust=0.5, hjust=-0.2)