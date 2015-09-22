dat <- read.csv('MERGED2013_PP.csv' , na.strings='NULL')
subDat <- dat[,c('NPT4_PUB', 'NPT4_PRIV', 'region', 'LOCALE')]
subDat$region <- factor(subDat$region)
subDat$LOCALE <- factor(subDat$LOCALE)

library(reshape)
melted <- melt(subDat, id=c('region', 'LOCALE'))
colnames(melted) <- c('region', 'locale', 'institution_type', 'net_price')
levels(melted$institution_type) <- c('public', 'private')

library(ggplot2)

ggsave('priceByRegion.pdf',
	ggplot(melted, aes(x=net_price, col=institution_type)) + 
    geom_histogram(aes(y=..density..), position="identity", alpha=.5) +
    facet_wrap(~region) + xlab('net price') + ggtitle('net price by region'))

ggsave('priceByLocale.pdf',
	ggplot(melted, aes(x=net_price, col=institution_type)) + 
    geom_histogram(aes(y=..density..), position="identity", alpha=.5) +
    facet_wrap(~locale) + xlab('net price') + ggtitle('net price by locale'))
