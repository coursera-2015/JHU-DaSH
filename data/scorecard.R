

## Load the data
scorecard <- read.csv("../data/Most+Recent+Cohorts+(Scorecard+Elements).csv")

library(data.table)
scorecard <- as.data.table(scorecard)
sort(names(scorecard))


## Merged data table
scorecard$isPublic <- ifelse(scorecard$CONTROL==1, TRUE, FALSE)


## Convert the "Average net price for Title IV institutions (public/private institutions)" to numeric
scorecard$NPT4_PUB <- as.character(scorecard$NPT4_PUB)
scorecard$NPT4_PRIV <- as.character(scorecard$NPT4_PRIV)
scorecard$averageNetPrice <- ifelse(scorecard$isPublic, scorecard$NPT4_PUB, scorecard$NPT4_PRIV)
scorecard$averageNetPrice <- as.integer(scorecard$averageNetPrice)

nrow(scorecard[scorecard$isPublic==TRUE])
nrow(scorecard[scorecard$isPublic==FALSE])



