library(shiny)
library(datasets)
library(ggplot2)
library(caret)
data("mtcars")
######################################
#global objects
dfCollege <- read.csv("fullset.csv")
dfCollege$LOCALE <- as.numeric(dfCollege$LOCALE)
dfCollege$region <- as.numeric(dfCollege$region) 

######################################
#functions
######################################
#calculateROI
calculateROI <- function(inpMajor, inpSAT, inpLocale, inpPopulation, inpRegion) {
  lmROI <- lm(roi ~ region+SAT_AVG+LOCALE+UGDS, data=dfCollege)
  returnROI <- predict(lmROI, data.frame(region=as.numeric(inpRegion), SAT_AVG=inpSAT, LOCALE=inpLocale, UGDS=inpPopulation))
  return(returnROI)
}


######################################
#shinyServer
#   main routine
shinyServer(
  function(input, output) {
    
    
    #explanatory variables
    output$selectedMajor <- renderPrint({input$selMajor})
    output$selectedLocale <- renderPrint({input$selLocale})
    output$selectedSAT <- renderPrint({input$selSAT})
    output$selectedPopulation <- renderPrint({input$slPopulation})
    output$selectedRegion <- renderPrint({input$selRegion})
    
    #selected model
    #output$selectedModel <- renderPrint({ input$rdoModel })
    
    output$predictedROI <- renderText(calculateROI(
                                        inpMajor = input$selMajor,
                                        inpSAT = as.numeric(input$selSAT),
                                        inpLocale  = as.numeric(input$selLocale),
                                        inpPopulation = input$slPopulation,
                                        inpRegion = input$selRegion
                                      ))
    

  }
)
