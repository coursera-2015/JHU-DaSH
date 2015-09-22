library(shiny)
library(datasets)
library(ggplot2)
library(caret)
data("mtcars")

######################################
#functions
######################################
#calculateMPG
calculateMPG <- function(model, weight, cylinders, displacement, chkWeight, chkCyl, chkDisp) {
  
  mMPG <- NULL
  testString <- "wt+cyl+disp"
  varString <- ""
  
  #build the explanatory variables depending on what was selected
  if (chkWeight) {
    varString <- paste0(varString,"wt+")
  }
  if (chkCyl) {
    varString <- paste0(varString,"cyl+")
  }
  if (chkDisp) {
    varString <- paste0(varString,"disp+")
  }
  #print(varString)
  #ditch the trailing plus
  varString <- gsub("[+]$","", varString, perl=T)

  #print(varString)
  
  if (model == "lm") {
    lmString <- paste0("lm(mpg ~ ",varString, ",data=mtcars)")
    mMPG <- eval(parse(text=lmString))
    #mMPG <- lm(mpg ~ wt+cyl+disp, data=mtcars)
  } else {
    rfString <- paste0("train(mpg ~ ",varString, ",data=mtcars, method='rf', prox=TRUE, importance=TRUE)")
    mMPG <- eval(parse(text=rfString))
    print(rfString)
    #mMPG <- train(mpg ~ ., data=mtcars, method="rf", prox=TRUE, importance=TRUE)
  }
  
  
  mpg <- predict(mMPG, data.frame(wt=weight, cyl=cylinders, disp=displacement))
  
  return(mpg)
}


######################################
#shinyServer
#   main routine
shinyServer(
  function(input, output) {
    
    selectedData <- reactive({
      mtcars[, c(input$expVar, "mpg")]
    })
    
    #PROBLEM: this is returning a string such as "cyl" instead of the variable cyl
    selectedVar <- reactive({
      print(input$expVar)
      input$expVar
    })
    
    #explanatory variables
    output$selectedCyl <- renderPrint({input$cyl})
    output$selectedWeight <- renderPrint({input$weight})
    output$selectedDisp <- renderPrint({input$disp})
    
    #selected model
    output$selectedModel <- renderPrint({ input$rdoModel })
    
    output$predictedMPG <- renderText(calculateMPG(model = input$rdoModel,
                                                   weight = as.numeric(input$weight), 
                                                   cylinders = as.numeric(input$cyl), 
                                                   displacement = as.numeric(input$disp),
                                                   chkWeight = as.numeric(input$chkWeight),
                                                   chkCyl = as.numeric(input$chkCyl),
                                                   chkDisp = as.numeric(input$chkDisp)
                                                   ))
    output$mpgPlot <- renderPlot({
      #abline(lm(mpg ~ mtcars$selectedVar(), data=mtcars), col="red")
      ggplot(mtcars, aes(x=wt, y=mpg, col=cyl, size=disp)) + geom_point(aes(shape=factor(am)))
    })
  }
)
