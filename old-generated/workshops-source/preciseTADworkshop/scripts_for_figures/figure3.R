#creating figure 3

library(preciseTAD)
library(GenomicRanges)
library(ggplot2)
library(ComplexHeatmap)


bounds <- extractBoundaries(domains.mat = arrowhead_gm12878_5kb, 
                            preprocess = FALSE, 
                            CHR = paste0("CHR",1:22), 
                            resolution = 5000)

path <- "../data/genomicElements"
tfbsList <- bedToGRangesList(filepath=path, bedList=NULL, bedNames=NULL, pattern = "*.bed", signal=4)

set.seed(123)
tadData <- createTADdata(bounds.GR = bounds,
                         resolution = 5000,
                         genomicElements.GR = tfbsList,
                         featureType = "distance",
                         resampling = "rus",
                         trainCHR = paste0("CHR",c(1:8,10:13,15:22)),
                         predictCHR = "CHR14")

set.seed(1)
rfe_res <- TADrfe(trainData = tadData[[1]],
                  tuneParams = list(ntree = 500, nodesize = 1),
                  cvFolds = 5,
                  cvMetric = "Accuracy",
                  verbose = TRUE)

rfe_res[[1]]

a <- ggplot(rfe_res[[1]], aes(x=Variables, y=Accuracy)) + 
    geom_errorbar(aes(ymin=Accuracy-AccuracySD, ymax=Accuracy+AccuracySD), 
                  width=2, 
                  size=1, 
                  color="red") +
    geom_line(size=2, color="red") +
    geom_point(size=4, color="red") +
    xlab("Number of Annotations") +
    ylab("Cross-Validated Accuracy") +
    scale_color_discrete(name="Cell line")+
    scale_x_continuous(breaks = c(2,4,8,16,32,52),
                       labels = c(2,4,8,16,32,52))+
    theme_minimal() +
    theme_bw()+
    theme(axis.text.x = element_text(size = 15),
          axis.text.y = element_text(size = 15),
          axis.title.x = element_text(size = 20),
          axis.title.y = element_text(size = 20),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          #strip.text.x = element_text(size = 15),
          #panel.spacing = unit(2, "lines"),
          legend.text=element_text(size=15),
          legend.title=element_text(size=20),
          plot.title = element_text(size=20),
          legend.position = "bottom")

################################################################################

rfe_res[[2]]

set.size = 8

rfeModelResults <- rfe_res[[2]]

rfeModelResults2 <- rfeModelResults %>%
    dplyr::filter(Variables==8) %>%
    dplyr::group_by(var) %>%
    dplyr::summarise(meanOverall = mean(Overall),
                     sdOverall = sd(Overall)) %>%
    dplyr::arrange(desc(meanOverall)) 

rfeModelResults2$var <- gsub(paste0(c("Gm12878", "-", "Sydh", "Haib", "Broad"), collapse = "|"), "", rfeModelResults2$var)

b1 <- ggplot(rfeModelResults2, aes(x=reorder(var, meanOverall), y=meanOverall, fill="red")) +
    geom_bar(stat="identity") +
    #geom_errorbar(aes(ymin=Performance-PerformanceSD, ymax=Performance+PerformanceSD), width=.75, size=1) +
    guides(fill=FALSE) +
    theme_minimal() +
    theme_bw()+
    xlab("Transcription Factor") + 
    ylab("Variable Importance") + 
    theme(axis.text.x = element_text(size=15),
    axis.text.y = element_text(size = 15),
    axis.title.x = element_text(size = 15),
    axis.title.y = element_text(size = 15),
    strip.text.x = element_text(size = 15),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.text=element_text(size=15),
    legend.title=element_text(size=15),
    legend.position = "bottom",
    plot.title = element_text(size=15)) +
    coord_flip()

#OR

rfeModelResults3 <- rfeModelResults %>%
    dplyr::filter(Variables==8) %>%
    dplyr::select(Overall, var, Resample)

rfeModelResults3$var <- gsub(paste0(c("Gm12878", "-", "Sydh", "Haib", "Broad"), collapse = "|"), "", rfeModelResults3$var)

rfeModelResults3 <- reshape(rfeModelResults3, idvar = "var", timevar = "Resample", direction = "wide")
rfeModelResults3[is.na(rfeModelResults3)] <- 0
rfeModelResults3 <- rfeModelResults3[order(rowMeans(rfeModelResults3[,-1], na.rm = TRUE),decreasing = TRUE),]
rfe.set.mat <- as.matrix(rfeModelResults3[,-1])
rownames(rfe.set.mat) <- rfeModelResults3$var

my_palette <- colorRampPalette(c("white", "red"))(ncol(rfe.set.mat))

b2 <- Heatmap(rfe.set.mat,
        col=my_palette,
        border=TRUE,
        cluster_rows=FALSE,
        clustering_distance_rows = "manhattan",
        cluster_columns=FALSE,
        show_row_names = TRUE,
        row_names_side="left",
        show_column_names = FALSE,
        column_names_gp=gpar(fontsize = 15),
        row_names_gp=gpar(fontsize = 20),
        column_names_rot = 45,
        column_names_centered =FALSE,
        show_heatmap_legend = FALSE,
        heatmap_legend_param = list(title = "",
                                    legend_direction = "vertical", 
                                    legend_height = unit(3, "in"),
                                    labels_gp = gpar(fontsize = 15)),
        rect_gp = gpar(col = "black", lwd = 1),
        column_dend_side = "top",
        column_names_side = "top")


