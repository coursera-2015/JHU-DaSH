dat <- read.csv('MERGED2005_PP.csv' , na.strings='NULL')
subDat <- subset(dat, dat$mn_earn_wne_p6 != 'PrivacySuppressed')

# Mean earnings of students working and not enrolled 6 years after entry
subDat$mn_earn_wne_p6 <-  as.numeric(levels(subDat$mn_earn_wne_p6 )[subDat$mn_earn_wne_p6 ])


earningsByState6 <- with(subDat, by(subDat, STABBR, function(ii){
	avgEarnings <- mean(ii$mn_earn_wne_p6)
	state <- tolower(state.name[which(state.abb==ii$STABBR[1])])

	tryCatch({data.frame(value=avgEarnings, region=state, stringsAsFactors=FALSE)},
		error = function(e){NULL})
}))
earningsByState6 <- earningsByState6[!sapply(earningsByState6, is.null)]
earningsByState6 <- do.call(rbind, earningsByState6)

library(choroplethr)
library(choroplethrMaps)

state_choropleth(earningsByState6, num_colors=1)
