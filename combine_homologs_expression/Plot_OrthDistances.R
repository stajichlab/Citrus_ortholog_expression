library(ggplot2)
library(tidyr)
library(plyr)
library(dplyr)

#library(tidymodels)
orthdist <- read.table("orth_distance.tsv")

hist(orthdistExtra$Crdist,100)
hist(log(orthdist$Crdist)/log(10),100)
cor(orthdist$Cs.expr,orthdist$Cr.expr)
ggplot(orthdist) + geom_point(aes(x=Cs.expr,Cr.expr))

orthdistFilt <- orthdist %>% 
    mutate( Cr.bin = if_else( Crdist == 0 | Crdist > 2000, 0, round(Crdist / 100))) %>%
    mutate( Cs.bin = if_else( Csdist == 0 | Csdist > 2000, 0, round(Csdist / 100))) %>%
    mutate( Cs.bin = if_else( Cs.bin < 0, -1, Cs.bin) ) %>% 
    mutate( Cr.bin = if_else( Cr.bin < 0, -1, Cr.bin) ) %>% filter(Cs.expr > 0 | Cr.expr > 0)

p <- ggplot(orthdistFilt, aes(Cr.bin,Cr.expr)) +
  geom_bar(position = 'dodge', stat = 'summary') +
  geom_errorbar(stat = 'summary', position = 'dodge', width = 0.9) 
p

p <- ggplot(orthdistFilt, aes(Cs.bin,Cs.expr)) + 
  geom_bar(position = 'dodge', stat = 'summary') +
  geom_errorbar(stat = 'summary', position = 'dodge', width = 0.9) 
p

ggplot(orthdistFilt) + geom_histogram(aes(x = Cr.expr,fill=Cr.bin),binwidth=100) +
  facet_wrap( Cr.bin ~ ., scales="free")

ggplot(orthdistFilt) + geom_histogram(aes(x = Cs.expr,fill=Cs.bin),binwidth=100) +
  facet_wrap( Cs.bin ~ ., scales="free") 

CrTE <- orthdistFilt %>% filter(Cs.bin == 0) %>% filter(Cr.bin > 0)
CsTE <- orthdistFilt %>% filter(Cr.bin == 0) %>% filter(Cs.bin > 0)

ggplot(CrTE) + geom_point(aes(x=Cs.expr,y=Cr.expr,fill=Cr.bin,color=Cr.bin))

ggplot(CsTE) + geom_point(aes(x=Cr.expr,y=Cs.expr,fill=Cs.bin,color=Cs.bin))
# old

#Crmed <- orthdist %>% filter(Crdist > 0) %>% filter(Crdist < 2000) %>%
#  filter(Cr.expr < 3000) %>% mutate(Cr.bin=round(Crdist / 500))

#Crmissing <- orthdist %>% filter(Crdist == 0 | Crdist >= 2000) %>% 
#    filter(Cr.expr < 3000 ) %>% mutate(Cr.bin=0)

#Cr <- bind_rows(Crmed,Crmissing)

#Csmed <- orthdist %>% filter(Csdist > 0) %>% 
#    filter(Csdist < 2000) %>%
#    filter(Cs.expr < 3000) %>% mutate(Cs.bin=round(Csdist / 500))

#Csmissing <- orthdist %>% filter(Csdist == 0 | Csdist >= 2000) %>% 
#    filter(Cs.expr < 3000) %>% mutate(Cs.bin=0)

#Cs <- bind_rows(Csmed,Csmissing)

