#creating table 3

library(preciseTAD)
library(GenomicRanges)

pt_chr14_gm12878 <- readRDS("../data/preciseTAD_5kb/preciseTAD_chr14_gm12878.rds")
arrowhead_chr14_gm12878 <- readRDS("../data/Arrowhead_5kb/arrowhead_gm12878_5kb_chr14.rds")

pt_chr14_k562 <- readRDS("../data/preciseTAD_5kb/preciseTAD_chr14_k562.rds")
arrowhead_chr14_k562 <- readRDS("../data/Arrowhead_5kb/arrowhead_k562_5kb_chr14.rds")

length(arrowhead_chr14_gm12878)
length(arrowhead_chr14_k562)

length(pt_chr14_gm12878$PTBP)
length(pt_chr14_k562$PTBP)

