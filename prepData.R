#some of this stuff not used
library(Metrics) #for errors
library(caret) #for dummy vars
library(data.table)
library(xgboost)
library(magrittr)
library(methods)
library(Matrix)
library(MASS)

options(scipen = 10)
rm(list=ls())

#useful, just in case, should be in R profile
`%notin%` <- function(x,y) !(x %in% y)

st= Sys.time()
homeDir = "/home/wally/jhudsh/tp2/JHU-DaSH/data"
setwd(homeDir)

load("scorecard.RData")
cost = scorecard
earn = fread("./earningsDataTrunc.csv", stringsAsFactors=FALSE)
reg = fread("/home/wally/jhudsh/reg.csv", stringsAsFactors=FALSE)
cost = cbind(cost, reg)
#earn$INSTNM = as.factor(earn$INSTNM)

cost = subset(cost, select=-c(NPCURL,INSTURL,INSTNM,NPT4_PUB,NPT4_PRIV)) ##,NPT4_PUB,NPT4_PRIV,INSTNM))

for (i in colnames(cost))
{
    #good as is
    if ( i %in% c("UNITID","OPEID","INSTNM","CITY", "STABBR") )
    {
        next
    }
    else
    {
        #possibly losing something turning factors/ints into floats
        cost[[i]] = as.numeric(cost[[i]])   
    }
}
    
#not sure why this doesn't work
#train = as.data.table(earn, cost, by.x="UNITID", by.y="UNITID")
train = as.data.table(merge(as.data.frame(earn),as.data.frame(cost), by.x="UNITID", 
                            by.y="UNITID", all.x=TRUE))

#Remove NA's, etc so xgboost doesn't bitch
ok = complete.cases(train)

train = train[ok,]
#what we're trying to measure
train[, roi := mn_earn_wne_p10/averageNetPrice]
y = train$roi

#explanantory variables (swagged, we didn't perform feature selection)
train2 = subset(train, select=c(UNITID,INSTNM,CITY,STABBR,SAT_AVG,UGDS,region,LOCALE,
                                GRAD_DEBT_MDN_SUPP,isPublic,PCIP01,PCIP03,PCIP11,PCIP13,
                                PCIP14,PCIP22,PCIP23,PCIP26,PCIP27,PCIP39,PCIP52,PCIP54,roi))

#convert percentages to binary, note min value is 1, not 0, in data files
train2[, nPCIP01 := ifelse(PCIP01 > 2, 1,0) ]
train2[, nPCIP03 := ifelse(PCIP03 > 2, 1,0) ]
train2[, nPCIP11 := ifelse(PCIP11 > 2, 1,0) ]
train2[, nPCIP13 := ifelse(PCIP13 > 2, 1,0) ]
train2[, nPCIP14 := ifelse(PCIP14 > 2, 1,0) ]
train2[, nPCIP22 := ifelse(PCIP22 > 2, 1,0) ]
train2[, nPCIP23 := ifelse(PCIP23 > 2, 1,0) ]
train2[, nPCIP26 := ifelse(PCIP26 > 2, 1,0) ]
train2[, nPCIP27 := ifelse(PCIP27 > 2, 1,0) ]
train2[, nPCIP39 := ifelse(PCIP39 > 2, 1,0) ]
train2[, nPCIP52 := ifelse(PCIP52 > 2, 1,0) ]
train2[, nPCIP54 := ifelse(PCIP54 > 2, 1,0) ]

train2 = subset(train2, select=-c(PCIP01,PCIP03,PCIP11,PCIP13, PCIP14,PCIP22,PCIP23,
                                  PCIP26,PCIP27,PCIP39,PCIP52,PCIP54))

write.csv(train2, "/home/wally/jhudsh/fullSet.csv",quote=FALSE,row.names=FALSE)