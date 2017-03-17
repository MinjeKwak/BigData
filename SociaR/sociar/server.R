#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(memoise)
library(rJava)
library(twitteR)
library(wordcloud)
library(RColorBrewer)
library(base64enc)
library(shiny)

function(input, output, session) {
  
  output$distPlot <- renderPlot({
    
    selection <- input$select
    
    key <- isolate(input$candidate)
    tweetFreq <- isolate(input$freq)
    tweetMax <- isolate(input$max)
    
    key <- enc2utf8(key)
    isolate({
      withProgress({
        setProgress(message = "Processing...")
        result <- searchTwitteR(key, n=1000)
      })
    })
    
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
    
    fin <- subset(word, subset=!(word == "재인"))
    fin <- subset(word, subset=!(word == "희정"))
    fin <- subset(word, subset=!(word == "재명"))
    fin <- subset(word, subset=!(word == "승민"))
    
    f <- nchar(fin$word) == 1
    fin2 <- subset(fin, subset=!f)
    
    pal <- brewer.pal(2, "Set1")
    wordcount <- table(fin2[[1]])
    
    # windowsFonts(nanum=windowsFont("나눔바른고딕"))
    # family="nanum"
    wordcloud(names(wordcount), freq = wordcount, scale = c(20, 1),
              min.freq = tweetFreq, max.words = tweetMax, colors = brewer.pal(8, "Dark2"))
  })
}
