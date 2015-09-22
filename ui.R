library(shiny)
library(datasets)
data("mtcars")

shinyUI(pageWithSidebar(
  headerPanel("Miles Per Gallon Tool"),
  sidebarPanel(
    h3('Inputs'),
    radioButtons("cyl", "Select the number of cylinders:",
                 c("4" = "4",
                   "6" = "6",
                   "8" = "8",
                   "10" = "10",
                   "12" = "12")
                               
    ),
    checkboxInput("chkCyl", label = "Use Cylinders", value = TRUE),
    h5('______________________'),
    
    sliderInput('weight', 'Enter weight (1000lbs)', min = 1, max = 10, value = 2, step = 1),
    checkboxInput("chkWeight", label = "Use Weight", value = TRUE),
    h5('______________________'),
    
    sliderInput('disp', 'Engine Displacement', min = 50, max = 500, value = 200, step = 10),
    checkboxInput("chkDisp", label = "Use Engine Displacement", value = TRUE),
    h5('______________________'),
    
    radioButtons("rdoModel", label = h4("Choose a Prediction Model"),
                 choices = list("Linear" = "lm", "Random Forest" = "rf"), 
                 selected = "lm"),
    
    h5('______________________'),
    
    #actionButton("rollButton", "Roll!")
    h4('Explanatory Variable'),
    selectInput('expVar', 'X variable', names(mtcars[,!colnames(mtcars) %in% c("mpg")]))
  ),
  mainPanel(
    h3('Your selections'),
    h4('Model Used: '),
    verbatimTextOutput('selectedModel'), 
    h4('Cylinders: '),
    verbatimTextOutput('selectedCyl'), 
    h4('Weight: '),
    verbatimTextOutput('selectedWeight'),
    h4('Engine Displacement: '),
    verbatimTextOutput('selectedDisp'),    
    h3("Predicted MPG:"),
    verbatimTextOutput('predictedMPG'),
    h4("Sample Plot"),
    # Create a space for the plot output
    plotOutput(
      "mpgPlot", "100%", "500px"
    )
    
    
  )
))
