library(shiny)
library(datasets)
library(ggplot2)
library(caret)
library(xgboost)
library(Matrix)

######################################
#global objects
collegeModel <- readRDS("./collegeModel.rds")

#DEPRECATED TRAINING CODE ########################
#dfCollege <- read.csv("./fullSet.csv")
#dfCollege$LOCALE <- as.numeric(dfCollege$LOCALE)
#dfCollege$region <- as.numeric(dfCollege$region) 
#dfCollege$UNITID <- NULL
#dfCollege$INSTNM <- NULL
#dfCollege$CITY <- NULL
#dfCollege$STABBR <- NULL
#dfCollege$GRAD_DEBT_MDN_SUPP <- NULL
#dfCollege$LOCALE <- NULL
#END DEPRECATED TRAINING CODE ########################



######################################
#functions
######################################
#calculateROI
calculateROI <- function(inpMajor, inpSAT, inpPopulation, inpRegion, inpPublic) {
  
  #DEPRECATED TRAINING CODE ########################
  #e.g. train is the data
  #y = dfCollege$roi
  #train2 = subset(dfCollege, select=-c(roi))

  #print('Debug 2')  
  #dtrn<-sparse.model.matrix(~.-1, data = train2)
  #mod = xgboost(data=dtrn, max.depth=6, eta=0.04, nthread=4, nround=100, objective = "reg:linear", 
  #              eval.metric="rmse", verbose=0, subsample=0.7, label=y)

  
  #print('Debug 3')   
  #END DEPRECATED CODE #############################
  
  predictDF <- data.frame(SAT_AVG=inpSAT,
                          UGDS=inpPopulation,
                          region=as.integer(inpRegion),
                          isPublic=as.integer(inpPublic),
                          nPCIP01=0,
                          nPCIP03=0,
                          nPCIP11=0,
                          nPCIP14=0,
                          nPCIP22=0,
                          nPCIP23=0,
                          nPCIP26=0,
                          nPCIP27=0,
                          nPCIP52=0,
                          nPCIP54=0
                          )
  #print('Debug 4')
  
  if (inpMajor == "nPCIP01"){
    predictDF$nPCIP01 <- 1
  } else if (inpMajor == "nPCIP03") {
    predictDF$nPCIP03 <- 1
  } else if (inpMajor == "nPCIP11") {
    predictDF$nPCIP11 <- 1
  } else if (inpMajor == "nPCIP14") {
    predictDF$nPCIP14 <- 1
  } else if (inpMajor == "nPCIP22") {
    predictDF$nPCIP22 <- 1
  } else if (inpMajor == "nPCIP23") {
    predictDF$nPCIP23 <- 1
  } else if (inpMajor == "nPCIP26") {
    predictDF$nPCIP26 <- 1
  } else if (inpMajor == "nPCIP27") {
    predictDF$nPCIP27 <- 1
  } else if (inpMajor == "nPCIP52") {
    predictDF$nPCIP52 <- 1
  } else if (inpMajor == "nPCIP54") {
    predictDF$nPCIP54 <- 1
  }
  
  #print('Debug 6')
  #print(str(predictDF))
  dtest<-sparse.model.matrix(~.-1, data = predictDF)
  
  #print('Debug 7')
  #returnROI = predict(mod,dtest)  
  returnROI <- predict(collegeModel, dtest)
  
  
 
  ### LINEAR MODEL CODE ###
  #lmROI <- lm(roi ~ region+SAT_AVG+LOCALE+UGDS, data=dfCollege)  
  #returnROI <- predict(lmROI, data.frame(nPCIP11=1,region=as.numeric(inpRegion), SAT_AVG=inpSAT, LOCALE=inpLocale, UGDS=inpPopulation, isPublic=as.numeric(inpPublic)))
  ### END LINEAR MODEL CODE ###
  
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
                                        #inpLocale  = as.numeric(input$selLocale),
                                        inpPopulation = input$slPopulation,
                                        inpRegion = input$selRegion,
                                        inpPublic = input$selPublic
                                      ))
    

  }
)
