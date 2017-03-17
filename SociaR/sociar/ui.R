#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

fluidPage(
  
  # Application title
  titlePanel("SociaR Wordcloud"),
  
  sidebarLayout(
    
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      img(src="bluehouse.png", height = 160, width = 240),
      br(),
      "대선 후보 6인의 실시간 트위터 키워드",
      hr(),
      selectInput("candidate", "후보를 선택하세요.",
                  c("문재인", "안희정", "이재명", "안철수", "심상정", "유승민")),
      hr(),
      sliderInput("freq",
                  "언급 빈도",
                  min = 1,  max = 100, value = 5),
      sliderInput("max",
                  "단어 수",
                  min = 1,  max = 50,  value = 20),
      hr(),
      actionButton("select", "선택")
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
)
