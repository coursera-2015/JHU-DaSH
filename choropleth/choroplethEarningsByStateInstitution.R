dat <- read.csv('MERGED2005_PP.csv' , na.strings='NULL')
subDat <- subset(dat, dat$mn_earn_wne_p6 != 'PrivacySuppressed')

# Mean earnings of students working and not enrolled 6 years after entry
subDat$mn_earn_wne_p6 <-  as.numeric(levels(subDat$mn_earn_wne_p6)[subDat$mn_earn_wne_p6])
subDat$CONTROL[subDat$CONTROL==3] <- 2 # combine private for-/non-profit


earningsByFactors6 <- with(subDat, by(subDat, list(STABBR,CONTROL), function(ii){
	avgEarnings <- mean(ii$mn_earn_wne_p6)
	state <- tolower(state.name[which(state.abb==ii$STABBR[1])])

	tryCatch({data.frame(value=avgEarnings, region=state, control=ii$CONTROL[1], stringsAsFactors=FALSE)},
		error = function(e){NULL})
}))
earningsByFactors6 <- earningsByFactors6[!sapply(earningsByFactors6, is.null)]
earningsByFactors6 <- do.call(rbind, earningsByFactors6)


library(choroplethr)
library(choroplethrMaps)

for(ii in unique(earningsByFactors6$control)){
	quartz()
	print(state_choropleth(subset(earningsByFactors6, earningsByFactors6$control==ii), num_colors=1))
}


