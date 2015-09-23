###############################################
#modelBuilder.R
#
library(caret)
library(xgboost)
library(Matrix)

##############################################
#read in the prepped data
print("Reading data..........................")
dfCollege <- read.csv("./fullSet.csv")
dfCollege$LOCALE <- as.numeric(dfCollege$LOCALE)
dfCollege$region <- as.numeric(dfCollege$region) 
dfCollege$UNITID <- NULL
dfCollege$INSTNM <- NULL
dfCollege$CITY <- NULL
dfCollege$STABBR <- NULL
dfCollege$GRAD_DEBT_MDN_SUPP <- NULL
dfCollege$LOCALE <- NULL


############################################
#build model
print("Building model......................")
y = dfCollege$roi
train2 = subset(dfCollege, select=-c(roi))


dtrn<-sparse.model.matrix(~.-1, data = train2)
mod = xgboost(data=dtrn, max.depth=6, eta=0.04, nthread=4, nround=2000, objective = "reg:linear", 
              eval.metric="rmse", verbose=0, subsample=0.7, label=y)



#########################################
#test model
predictDF <- data.frame(SAT_AVG=333,
                        UGDS=1483,
                        region=5,
                        isPublic=1,
                        nPCIP01=0,
                        nPCIP03=0,
                        nPCIP11=1,
                        nPCIP14=0,
                        nPCIP22=0,
                        nPCIP23=0,
                        nPCIP26=0,
                        nPCIP27=0,
                        nPCIP52=0,
                        nPCIP54=0
)

dtest<-sparse.model.matrix(~.-1, data = predictDF)

returnROI = predict(mod,dtest) 

print(paste("Predicted value ratio is:", returnROI))

#######################################
#save model
saveRDS(mod, 'collegeModel.rds')

print("Model has been saved")

