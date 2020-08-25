library(ggplot2)
library(dplyr)
library(tidyverse)
pdf("ggplots.pdf")

orthtable <- read_delim("Citrus_orthologs_TPM.tsv",delim="\t",
                        col_names = TRUE)
length(orthtable$Orthogroup) # how many rows?
orthtable.filter = orthtable %>% filter(Cs.expr > 10 & Cr.expr > 10)
length(orthtable.filter$Orthogroup) # how many rows?

orthtable.filter$foldchange <- log(orthtable.filter$Cs.expr/orthtable.filter$Cr.expr)/log(2)
hist(orthtable.filter$foldchange,breaks=100)

twofold_upDown = orthtable.filter %>% filter(foldchange > 1 | foldchange < -1)
#  this is the same thing as above
#twofold_upDown = subset(orthtable.filter, orthtable.filter$foldchange > 1 | orthtable.filter$foldchange < -1)

hist(twofold_upDown$foldchange,breaks=100)
ggplot(twofold_upDown, aes(x=log(Cs.expr), y=log(Cr.expr))) + geom_point()

ggplot(orthtable.filter, aes(x=log(Cs.expr), y=log(Cr.expr))) + geom_point()
ggplot(orthtable.filter, aes(x=Cs.expr, y=Cr.expr)) + geom_point()
cor(orthtable.filter$Cs.expr,orthtable.filter$Cr.expr)

dev.off()
