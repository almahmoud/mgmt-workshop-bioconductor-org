#creating figure 7B

library(preciseTAD)
library(GenomicRanges)

pt_chr14_k_on_gm <- readRDS("../data/preciseTAD_5kb/preciseTAD_chr14_k562_gm12878.rds")

pt_chr14_k_on_gm <- pt_chr14_k_on_gm$PTBP

pt_chr14_k_on_gm_df <- data.frame(chr=as.character(seqnames(pt_chr14_k_on_gm)),
                                  start=start(pt_chr14_k_on_gm),
                                  end=start(pt_chr14_k_on_gm)+1) 
write.table(pt_chr14_gm12878_df,
            "~/pt_chr14_k_on_gm.bed",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE,
            sep = "\t")

computeMatrix reference-point --referencePoint TSS -S ~/gm12878_ctcf.bigWig -R ~/pt_chr14_gm12878.bed ~/biocWorkshop/pt_chr14_k_on_gm.bed --binSize 50 -a 5000 -b 5000 -o ~/pt_arrow_g_on_g_k_on_g_ctcf.gz

plotProfile -m ~/pt_arrow_g_on_g_k_on_g_ctcf.gz -out ~/pt_g_on_g_k_on_g_ctcf.png --colors "#E6A0C4" "#C6CDF7" --regionsLabel "K on GM" "GM on GM"  --samplesLabel CTCF --refPointLabel Boundary --plotHeight 7 --plotWidth 7 --dpi 300
