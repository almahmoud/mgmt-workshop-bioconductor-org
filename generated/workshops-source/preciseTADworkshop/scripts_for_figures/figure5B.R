#creating figure 5B

library(preciseTAD)
library(GenomicRanges)
library(ggplot2)

pt_chr14_gm12878 <- readRDS("../data/preciseTAD_5kb/preciseTAD_chr14_gm12878.rds")
arrowhead_chr14_gm12878 <- readRDS("C:/Users/stili/Documents/preciseTADworkshop/data/Arrowhead_5kb/arrowhead_gm12878_5kb_chr14.rds")

pt_chr14_k562 <- readRDS("../data/preciseTAD_5kb/preciseTAD_chr14_k562.rds")
arrowhead_chr14_k562 <- readRDS("C:/Users/stili/Documents/preciseTADworkshop/data/Arrowhead_5kb/arrowhead_k562_5kb_chr14.rds")

pt_chr14_gm12878 <- pt_chr14_gm12878$PTBP
pt_chr14_k562 <- pt_chr14_k562$PTBP

path <- "../data/genomicElements"
tfbsList <- bedToGRangesList(filepath=path, bedList=NULL, bedNames=NULL, pattern = "*.bed", signal=4)


pred_v_called_df_gm12878 <- data.frame(LogDist = c(#preciseTAD
    log2(mcols(distanceToNearest(pt_chr14_gm12878, tfbsList[[8]]))$distance+1),
    
    #ARROWHEAD
    log2(mcols(distanceToNearest(arrowhead_chr14_gm12878, tfbsList[[8]]))$distance+1)
    ),
BoundReg = c(#preciseTAD
    rep("preciseTAD", length(log2(mcols(distanceToNearest(pt_chr14_gm12878, tfbsList[[8]]))$distance+1))),
    
    #ARROWHEAD
    rep("Arrowhead", length(log2(mcols(distanceToNearest(arrowhead_chr14_gm12878, tfbsList[[8]]))$distance+1)))
    )
)
pred_v_called_df_gm12878$BoundReg <- factor(pred_v_called_df_gm12878$BoundReg, levels=c("Arrowhead", "preciseTAD"))

ggplot(pred_v_called_df_gm12878, aes(x=BoundReg, y = LogDist, fill=BoundReg))  +  
    geom_violin(color="black", size=1.2) +
    #stat_boxplot(geom ='errorbar', width = 0.2, size=1.2) + 
    geom_boxplot(outlier.shape = NA, color="black", size=1.2, width=.1, fill="white") +
    geom_signif(test = "wilcox.test", 
                comparisons = list(c("preciseTAD","Arrowhead")),
                vjust = 0,
                textsize = 5,
                size = .5,
                step_increase = .5,
                color="black") +
    theme_minimal()+
    theme_bw()+
    ylab("Log2 distance to CTCF")+
    xlab("TAD calling tool") +
    ylim(0,19) +
    scale_fill_manual(values=c("blue",
                               "forestgreen"))+
    scale_color_manual(values=c("blue",
                                "forestgreen")) +
    guides(color=FALSE, fill=FALSE)+
    theme(axis.text.x = element_text(size=15,
                                     angle = 45,
                                     hjust = 1),
          axis.text.y = element_text(size = 15),
          axis.title.x = element_text(size = 15),
          axis.title.y = element_text(size = 15),
          strip.text.x = element_text(size = 15),
          #panel.spacing = unit(2, "lines"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.text=element_text(size=15),
          legend.title=element_text(size=15),
          plot.title = element_text(size=15),
          legend.position = "bottom")
