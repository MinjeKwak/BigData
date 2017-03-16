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
  
  # selection <- eventReactive(input$select, {
  #   runif(input$candidate)
  # })
  
  output$distPlot <- renderPlot({
    selection <- input$candidate
    key <- selection
    key <- enc2utf8(key)
    result <- searchTwitteR(key, n=1000)
    
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
    
    wordcloud(names(wordcount), freq = wordcount, scale = c(5,1), rot.per = 0.25,
              min.freq = 2, colors = brewer.pal(8, "Dark2"))
  })
}
