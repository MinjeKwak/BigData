library(memoise)
library(rJava)
library(twitteR)
library(wordcloud)
library(RColorBrewer)
library(base64enc)
library(shiny)

# Twitter authentication
api_key <- "misqNlwDekEBPtr6AJjegqNbo"
api_key_secret <- "5xC8EnPnHo6SHtX9WtUpkLzlQ193wam8cXXLxjzGDjQltm67q0"

access_token <- "841444906275020801-h6rzhzUQwtbflpt041SPg5tHs7VPVOj"
access_token_secret <- "PEQbQR8G0SWD65dnaccFlsb94bdGKZPOYwqFnrRp8dNUJ"

setup_twitter_oauth(api_key, api_key_secret, access_token, access_token_secret)
rm(list=ls())

# rJava initialization and crawling tweets
.jinit()
.jaddClassPath("analyzer.jar")
.jclassPath()

ma <- .jnew("komoran/analyzer")