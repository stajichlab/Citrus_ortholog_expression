library(ggplot2)
library(dplyr)
library(tidyverse)

orthtable <- read_delim("Citrus_Orthologs_v20200817.tsv",delim="\t",
                        col_names = c("OrthoGroup","Cs", "Cr", "Cs.expr","Cr.expr"))
length(orthtable$OrthoGroup) # how many rows?
orthtable.filter = orthtable %>% filter(Cs.expr > 0 & Cr.expr > 0)
length(orthtable.filter$OrthoGroup) # how many rows?

pdf("ggplots.pdf")
ggplot(orthtable.filter, aes(x=log(Cs.expr), y=log(Cr.expr))) + geom_point()
ggplot(orthtable.filter, aes(x=Cs.expr, y=Cr.expr)) + geom_point()
cor(orthtable.filter$Cs.expr,orthtable.filter$Cr.expr)
dev.off()
