library(ggplot2)
library(dplyr)
library(tidyverse)

orthtable <- read_delim("Citrus_Orthologs_v20200817.tsv",delim="\t",
                        col_names = c("OrthoGroup","Cs", "Cr", "Cs.expr","Cr.expr"))
pdf("ggplots.pdf")
ggplot(orthtable, aes(x=log(Cs.expr), y=log(Cr.expr))) + geom_point()
ggplot(orthtable, aes(x=Cs.expr, y=Cr.expr)) + geom_point()
cor(orthtable$Cs.expr,orthtable$Cr.expr)
dev.off()
