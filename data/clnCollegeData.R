options(scipen = 10)
library(data.table)

setwd("/home/wally/jhudsh")
rm(list=ls())
#Change file NAMES to avoid overwrite
#train = fread("./cdat/CollegeScorecardDataDictionary-09-12-2015.csv",stringsAsFactors=TRUE)

#link "Scorecard data" on https://collegescorecard.ed.gov/data/
earn  = fread("./data2/earn.csv", stringsAsFactors=FALSE)
#link "Post-school earnings" on https://collegescorecard.ed.gov/data/
cost = fread("./data2/cost.csv", stringsAsFactors=FALSE)

earn = subset(earn, select=-c(fsend_1,fsend_2,fsend_3,fsend_4,fsend_5))
#remove all variables beginning "count_..."
earn  = subset(earn, select=-grep("count_", colnames(earn), perl=TRUE))
tearn = subset(earn, select=c(mn_earn_wne_p10, mn_earn_wne_male0_p10,
                                mn_earn_wne_male1_p10))
#remove all mean earnings columns except 3 above
earn = subset(earn, select=-grep("mn_earn_", colnames(earn), perl=TRUE))
earn = cbind(earn, tearn)
#remove all greater than 25k columns
earn = subset(earn, select=-grep("gt_25k_", colnames(earn), perl=TRUE))
#remove percentage variables except e.g. 'pct black"
earn = subset(earn, select=-grep("pct10_", colnames(earn), perl=TRUE))
earn = subset(earn, select=-grep("pct25_", colnames(earn), perl=TRUE))
earn = subset(earn, select=-grep("pct75_", colnames(earn), perl=TRUE))
earn = subset(earn, select=-grep("pct90_", colnames(earn), perl=TRUE))
#remove median stuff (maybe more valuable than mean?)
earn = subset(earn, select=-grep("md_", colnames(earn), perl=TRUE))
#rem sd 
earn = subset(earn, select=-grep("sd_", colnames(earn), perl=TRUE))

#remove schools with NULL for main earning variable
earn2= earn[mn_earn_wne_p10 != "NULL" & mn_earn_wne_p10 != "PrivacySuppressed",]

idstuff = subset(earn2, select=c(UNITID, INSTNM))
edat = subset(earn2, select=-c(UNITID, INSTNM))
edat = edat

#NA's will be introduced by trying to convert 'NULL' and 'PrivacySuppressed'
#among other chaff that may be in there
for (i in colnames(edat))
{
  edat[[i]] = as.numeric(edat[[i]])
}

earn = cbind(idstuff, edat)
write.table(earn, "./data2/earningsDataTrunc.csv", sep=",",row.names=FALSE)






