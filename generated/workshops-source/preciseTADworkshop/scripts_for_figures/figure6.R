#creating figure 6

library(preciseTAD)
library(GenomicRanges)
library(Vennerable)
library(VennDiagram)
library(ChIPpeakAnno)
library(ggsci)

pt_chr14_gm12878 <- readRDS("../data/preciseTAD_5kb/preciseTAD_chr14_gm12878.rds")
arrowhead_chr14_gm12878 <- readRDS("../data/Arrowhead_5kb/arrowhead_gm12878_5kb_chr14.rds")

pt_chr14_k562 <- readRDS("../data/preciseTAD_5kb/preciseTAD_chr14_k562.rds")
arrowhead_chr14_k562 <- readRDS("../data/Arrowhead_5kb/arrowhead_k562_5kb_chr14.rds")

pt_chr14_gm12878 <- pt_chr14_gm12878$PTBP
pt_chr14_k562 <- pt_chr14_k562$PTBP

pt_chr14_gm12878 <- flank(pt_chr14_gm12878, 5000, both=TRUE)
pt_chr14_k562 <- flank(pt_chr14_k562, 5000, both=TRUE)
arrowhead_chr14_gm12878 <- flank(arrowhead_chr14_gm12878, 5000, both=TRUE)
arrowhead_chr14_k562 <- flank(arrowhead_chr14_k562, 5000, both=TRUE)

venn_cnt2venn <- function(venn_cnt){
    n <- which(colnames(venn_cnt)=="Counts") - 1
    SetNames=colnames(venn_cnt)[1:n]
    Weight=venn_cnt[,"Counts"]
    names(Weight) <- apply(venn_cnt[,1:n], 1, paste, collapse="")
    Venn(SetNames=SetNames, Weight=Weight)
}

jaccard = function(query, reference, restrict = NULL) {
    if(is.null(restrict)) {
        res = sum(width(GenomicRanges::intersect(query, reference))) / sum(as.numeric(width(GenomicRanges::union(query, reference))))
    } else {
        gr1 = GenomicRanges::intersect(query, reference)
        gr1 = GenomicRanges::intersect(gr1, restrict)
        
        gr2 = GenomicRanges::union(query, reference)
        gr2 = GenomicRanges::intersect(gr2, restrict)
        res = sum(width(gr1)) / sum(width(gr2))
    }
    return(res)
}

#arrowhead
res <- makeVennDiagram(Peaks=list(arrowhead_chr14_gm12878,
                                  arrowhead_chr14_k562),
                       NameOfPeaks=c("GM12878", "K562"))
venn.pt <- venn_cnt2venn(res$vennCounts)
venn.pt <- compute.Venn(venn.pt)
gp <- VennThemes(venn.pt)
gp[["Face"]][["11"]]$fill <-  "#D8A499"
gp[["Face"]][["01"]]$fill <-  "#E6A0C4"
gp[["Face"]][["10"]]$fill <-  "#C6CDF7"
gp$Set$Set1$col <- "#C6CDF7"
gp$Set$Set2$col <- "#E6A0C4"
gp[["FaceText"]][["10"]]$cex <- 2
gp[["FaceText"]][["11"]]$cex <- 2
gp[["FaceText"]][["01"]]$cex <- 2
gp[["SetText"]][["Set1"]]$cex <- 2
gp[["SetText"]][["Set2"]]$cex <- 2
gp$SetText$Set1$col <- "#C6CDF7"
gp$SetText$Set2$col <- "#E6A0C4"
gridExtra::grid.arrange(grid::grid.grabExpr(plot(venn.pt, gp = gp, show=list(Universe=FALSE))), top=textGrob("", gp=gpar(fontsize=50)))

jaccard(arrowhead_chr14_gm12878,
        arrowhead_chr14_k562)


#preciseTAD
res <- makeVennDiagram(Peaks=list(pt_chr14_gm12878,
                                  pt_chr14_k562),
                       NameOfPeaks=c("GM12878", "K562"))
venn.pt <- venn_cnt2venn(res$vennCounts)
venn.pt <- compute.Venn(venn.pt)
gp <- VennThemes(venn.pt)
gp[["Face"]][["11"]]$fill <-  "#D8A499"
gp[["Face"]][["01"]]$fill <-  "#E6A0C4"
gp[["Face"]][["10"]]$fill <-  "#C6CDF7"
gp$Set$Set1$col <- "#C6CDF7"
gp$Set$Set2$col <- "#E6A0C4"
gp[["FaceText"]][["10"]]$cex <- 2
gp[["FaceText"]][["11"]]$cex <- 2
gp[["FaceText"]][["01"]]$cex <- 2
gp[["SetText"]][["Set1"]]$cex <- 2
gp[["SetText"]][["Set2"]]$cex <- 2
gp$SetText$Set1$col <- "#C6CDF7"
gp$SetText$Set2$col <- "#E6A0C4"
gridExtra::grid.arrange(grid::grid.grabExpr(plot(venn.pt, gp = gp, show=list(Universe=FALSE))), top=textGrob("", gp=gpar(fontsize=50)))

jaccard(pt_chr14_gm12878,
        pt_chr14_k562)
