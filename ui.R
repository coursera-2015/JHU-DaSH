library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Cost of College"),
  sidebarPanel(
    h3('Inputs'),
    selectInput("selMajor", "Major:", 
                choices = list(
                  "Agriculture" = "nPCIP01",    
                  "Conservation" = "nPCIP03",
                  "Computer Science" = "nPCIP11",
                  "Education" = "nPCIP13",
                  "Engineering" = "nPCIP14",
                  "Legal" = "nPCIP22",
                  "English/Literature" = "nPCIP23",
                  "Biology" = "nPCIP26",
                  "Mathematics" = "nPCIP27",
                  "Theology" = "nPCIP39",
                  "Business" = "nPCIP52",
                  "History" = "nPCIP54"
                ),
                selected = "nPCIP11"),
    
    selectInput("selPublic", "Public/Private:", 
                choices = list(
                  "Public" = "1",    
                  "Private" = "0"
                ),
                selected = "1"),
    
     selectInput("selLocale", "Location:", 
                choices = list(
                  "City: Large" = 11,
                  "City: Midsize" = 12,
                  "City: Small" = 13,
                  "Suburb: Large" = 21,
                  "Suburb: Midzie" = 22,
                  "Suburb: Small" = 23,
                  "Town: Fringe" = 31,
                  "Town: Distant" = 32,
                  "Town: Remote" = 33,
                  "Rural: Fringe" = 41,
                  "Rural: Distant" = 42,
                  "Rural: Remote" = 43
              ),
              selected = 11), 
    selectInput("selRegion", "Region:", 
                choices = list(
                  "U.S. Service Schools" = 0, 
                  "New England (CT, ME, MA, NH, RI, VT)" = 1, 
                  "Mid East (DE, DC, MD, NJ, NY, PA)" = 2,
                  "Great Lakes (IL, IN, MI, OH, WI)" = 3,
                  "Plains (IA, KS, MN, MO, NE, ND, SD)" = 4,
                  "Southeast (AL, AR, FL, GA, KY, LA, MS, NC, SC, TN, VA, WV)" = 5,
                  "Southwest (AZ, NM, OK, TX)" = 6,
                  "Rocky Mountains (CO, ID, MT, UT, WY)" = 7,
                  "Far West (AK, CA, HI, NV, OR, WA)" = 8,
                  "Outlying Areas (AS, FM, GU, MH, MP, PR, PW, VI)" = 9
                ), 
                selected=5),
    sliderInput("selSAT", "Average SAT", min = 100, max=1000, value=200, step = 10),
    sliderInput('slPopulation', 'Number of students', min = 500, max = 2000, value = 1000, step = 100),

    h5('______________________'),    
    radioButtons("rdoModel", label = h4("Choose a Prediction Model"),
                 choices = list("Linear" = "lm", "Random Forest" = "rf"), 
                 selected = "lm")
    

  ),
  mainPanel(
    h3('Your selections'),
    h4('Major: '),
    verbatimTextOutput('selectedMajor'), 
    h4('Locale: '),
    verbatimTextOutput('selectedLocale'), 
    h4('Average SAT: '),
    verbatimTextOutput('selectedSAT'),
    h4('Region: '),
    verbatimTextOutput('selectedRegion'),    
    h4('Student Population: '),
    verbatimTextOutput('selectedPopulation'),    
    h3("Predicted ROI:"),
    verbatimTextOutput('predictedROI')

    
  )
))
