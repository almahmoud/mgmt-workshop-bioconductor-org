#creating figure 5A

library(preciseTAD)
library(GenomicRanges)

pt_chr14_gm12878 <- readRDS("../data/preciseTAD_5kb/preciseTAD_chr14_gm12878.rds")
arrowhead_chr14_gm12878 <- readRDS("../data/Arrowhead_5kb/arrowhead_gm12878_5kb_chr14.rds")

pt_chr14_gm12878 <- pt_chr14_gm12878$PTBP

pt_chr14_gm12878_df <- data.frame(chr=as.character(seqnames(pt_chr14_gm12878)),
                                  start=start(pt_chr14_gm12878),
                                  end=start(pt_chr14_gm12878)+1) 
write.table(pt_chr14_gm12878_df,
            "~/pt_chr14_gm12878.bed",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE,
            sep = "\t")


arrowhead_chr14_gm12878_df <- data.frame(chr=as.character(seqnames(arrowhead_chr14_gm12878)),
                                  start=start(arrowhead_chr14_gm12878),
                                  end=start(arrowhead_chr14_gm12878)+1) 
write.table(arrowhead_chr14_gm12878_df,
            "~/arrowhead_chr14_gm12878.bed",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE,
            sep = "\t")


#arrowhead

##gm12878

computeMatrix reference-point --referencePoint TSS -S ~/gm12878_ctcf.bigWig -R ~/arrowhead_chr14_gm12878.bed --binSize 50 -a 5000 -b 5000 -o ~/arrowhead_chr14_gm12878_cm.gz

plotHeatmap -m ~/arrowhead_chr14_gm12878_cm.gz -out /home/stilianoudakisc ~/arrowhead_chr14_gm12878_ctcf.png --whatToShow "plot, heatmap and colorbar" --regionsLabel "CTCF" --xAxisLabel " " --refPointLabel "Boundary" --samplesLabel "Arrowhead (GM12878)" --heatmapHeight 25 --heatmapWidth 5 --dpi 300

#preciseTAD

##gm12878

computeMatrix reference-point --referencePoint TSS -S ~/gm12878_ctcf.bigWig -R ~/pt_chr14_gm12878.bed --binSize 50 -a 5000 -b 5000 -o ~/pt_chr14_gm12878_cm.gz

plotHeatmap -m ~/pt_chr14_gm12878_cm.gz -out /home/stilianoudakisc ~/pt_chr14_gm12878_ctcf.png --whatToShow "plot, heatmap and colorbar" --regionsLabel "CTCF" --xAxisLabel " " --refPointLabel "Boundary" --samplesLabel "preciseTAD (GM12878)" --heatmapHeight 25 --heatmapWidth 5 --dpi 300

