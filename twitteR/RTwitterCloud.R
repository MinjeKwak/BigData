library(rJava)
library(twitteR)
library(wordcloud)
library(RColorBrewer)
library(base64enc)

api_key <- "misqNlwDekEBPtr6AJjegqNbo"
api_key_secret <- "5xC8EnPnHo6SHtX9WtUpkLzlQ193wam8cXXLxjzGDjQltm67q0"

access_token <- "841444906275020801-h6rzhzUQwtbflpt041SPg5tHs7VPVOj"
access_token_secret <- "PEQbQR8G0SWD65dnaccFlsb94bdGKZPOYwqFnrRp8dNUJ"

setup_twitter_oauth(api_key, api_key_secret, access_token, access_token_secret)
rm(list=ls())

.jinit()
.jaddClassPath("newAnalyzer.jar")
.jclassPath()

ma <- .jnew("ma/Analyzer")
key <- "취업"
key <- enc2utf8(key)
result <- searchTwitteR(key, n=1000)

# Sys.setlocale(locale="C")
DF <- twListToDF(result)

m <- gregexpr("([가-힣]+ +[가-힣]+)+", DF$text)
txt <- regmatches(DF$text, m)
txt2 <- lapply(txt, paste, collapse=" ")
txt3 <- unlist(txt2)

arr <- .jarray(txt3)
Result <- ma$analyze(arr)

word <- unlist(strsplit(Result, "\\/"))
odd <- seq(from=1, by=2, length=length(word)/2)
even <- seq(from=2, by=2, length=length(word)/2)
w <- word[odd]
t <- word[even]

word <- data.frame(word=w, tag=t, stringsAsFactors = F)
word <- word[grepl("^N+", word$tag),]
word <- subset(word, subset = (tag != "NNB"))

fin <- subset(word, subset=!(word == key))
f <- nchar(fin$word) == 1
fin2 <- subset(fin, subset=!f)

pal <- brewer.pal(2, "Set1")
wordcount <- table(fin2[[1]])
wordcloud(names(wordcount), freq = wordcount, scale = c(5,1), rot.per = 0.25, min.freq = 2, random.order = F, random.color = T, colors = pal)

