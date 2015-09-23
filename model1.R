#some of this stuff not used
library(Metrics) #for errors
library(caret) #for dummy vars
library(data.table)
library(xgboost)
library(magrittr)
library(methods)
library(Matrix)
library(MASS)
library(randomForest)

options(scipen = 10)
rm(list=ls())

#useful, just in case, should be in R profile
`%notin%` <- function(x,y) !(x %in% y)

st= Sys.time()
homeDir = "/home/wally/jhudsh/"
setwd(homeDir)

train = fread("fullSet.csv")
y = train$roi
train2 = subset(train, select=-c(roi,INSTNM,CITY,STABBR,UNITID))
#train2 = subset(train2, select=-c(nPCIP01,nPCIP03,nPCIP11,nPCIP13,nPCIP14,nPCIP22,nPCIP23,
#                                  nPCIP26,nPCIP27,nPCIP39,nPCIP52,nPCIP54))

# xgboost
dtrn<-sparse.model.matrix(~.-1, data = train2)
mod = xgboost(data=dtrn, max.depth=6, eta=0.04, nthread=4, nround=100, objective = "reg:linear", 
              eval.metric="rmse", verbose=0, subsample=0.7, label=y)
#Should consider out of sample testing
#saveRDS(mod, "xgboostMod1.RDS")
#mod2 = readRDS("xgboostMod1.RDS")
yin = predict(mod,dtrn)

#Plain ole lm
#train3 = cbind(train2, y)
#mod = lm(y ~ ., data=train3)
#mod = randomForest(y ~ ., data=train3, ntree =200, do.trace = 2, mtry=6)
#yin = predict(mod,train3)

rmse = sqrt(sum((yin-y)^2)/length(yin))
print(rmse)

#quick prediction test
#test = data.table(GRAD_DEBT_MDN_SUPP=300,isPublic=0,LOCALE=9,nPCIP01=0,nPCIP03=0,nPCIP11=1,nPCIP13=0,
#                  nPCIP14=0,nPCIP22=0, nPCIP23=0,nPCIP26=0,nPCIP27=0,nPCIP39=0,nPCIP52=1,UGDS=3000,SAT_AVG=700)
#test = data.table(SAT_AVG=700, nPCIP11=1)
test<- data.frame(SAT_AVG=333,
                        UGDS=1343,
                        region=5,
                        isPublic=1,
                        nPCIP01=0,
                        nPCIP03=0,
                        nPCIP11=0,
                        nPCIP14=0,
                        nPCIP22=0,
                        nPCIP23=0,
                        nPCIP26=0,
                        nPCIP27=0,
                        nPCIP52=0,
                        nPCIP54=0)

dtst<-sparse.model.matrix(~.-1, data = test)
yout = predict(mod,dtst)
print(yout)

#nimp = xgb.importance(dimnames(dtrn)[[2]], model=bst)
#fname = paste(homeDir, "varImp.csv", sep="")
#write.csv(nimp,fname, quote=FALSE,row.names=FALSE)
#foo2 = subset(foo, select=c(INSTNM,roi,averageNetPrice,mn_earn_wne_p10))
#foo = train[order(roi)]


