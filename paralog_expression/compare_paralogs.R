library(ggplot2)
library(dplyr)
library(tidyverse)

TPM <- read_delim("Citrus_paralogs_TPM.tsv",delim="\t",col_names=TRUE)

SumExpr <- TPM %>% filter( Expr > 0) %>% group_by(Orthogroup,Species) %>%
  summarise(avg = mean(Expr),
           # median = median(Expr),
            #max = max(Expr), 
            #min = min(Expr), 
            #n = n(),
            ) %>% 
  arrange(avg)

SumExpr.Cs <- SumExpr %>% filter(Species == "Cs") %>% rename(Cs.avg = avg) %>% select( -Species)
SumExpr.Cr <- SumExpr %>% filter(Species == "Cr") %>% rename(Cr.avg = avg) %>% select( -Species)
Combine = inner_join(SumExpr.Cs, SumExpr.Cr)
plot(log(Combine$Cs.avg),log(Combine$Cr.avg))
plot(Combine$Cs.avg,Combine$Cr.avg)