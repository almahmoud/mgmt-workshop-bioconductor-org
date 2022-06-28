# Single cell RNA-seq analysis workshop

## Overview

In this workshop, you will learn how to analyse single-cell RNA-seq count data using Seurat.
This workshop uses the 10X Genomics dataset from [Pal et al. 2021](https://doi.org/10.15252/embj.2020107333), from which we will consider five samples from human normal sorted epithelial population.
This workshop includes the following three parts:
* Standard analysis of one sample
* Integration analysis of multiple samples
* Differential expression analysis using pseudo-bulk

The detailed material can be found [here](https://yunshun.github.io/SingleCellWorkshop/articles/SingleCellWorkshop.html).

## Pre-requisites 

The course is aimed at PhD students, Master's students, and third & fourth year undergraduate students. 
Some basic R knowledge is assumed - this is not an introduction to R course. 
If you are not familiar with the R statistical programming language it is compulsory that you work through an introductory R course before you attend this workshop.

## _R_ packages used

The following R packages will be used: 

* Seurat
* edgeR
* vcd
* scales
* pheatmap

## Time outline

| Activity                         | Time |
|----------------------------------|------|
| Introduction & setup             | 10m  |
| Part 1. Standard analysis        | 35m  |
| Part 2. Integration analysis     | 35m  |
| Part 3. Pseudo-bulk DE analysis  | 30m  |
| Q & A                            | 10m  |


## Workshop goals and objectives

### Learning goals

 - Learn the standard scRNA-seq analysis pipeline.
 - Understand the process of single cell integration analysis.
 - Understand the biological variation between samples in single cell experiments and how to account for it.

### Learning objectives

 - Perform a standard analysis of a single 10X scRNA-seq sample.
 - Perform an integration analysis of multiple 10X scRNA-seq samples.
 - Apply the pseudo-bulk approach to DE analysis.


## Workshop package installation 

### Guide

This is necessary in order to reproduce the code shown in the workshop. 
The workshop is designed for R `4.1` and can be installed using one of the two ways below.

### Via Docker image

If you're familiar with [Docker](https://docs.docker.com/get-docker/) you could use the Docker image which has all the software pre-configured to the correct versions.

```
docker run -e PASSWORD=abc -p 8787:8787 yunshun/singlecellworkshop:latest
```

Once running, navigate to <http://localhost:8787/> and then login with
`Username:rstudio` and `Password:abc`.

You should see the Rmarkdown file with all the workshop code which you can run.

### Via GitHub

Alternatively, you could install the workshop using the commands below in R `4.1`.

```
install.packages('remotes')

# Install workshop package
remotes::install_github("yunshun/SingleCellWorkshop", build_vignettes = TRUE)

# To view vignettes
library(SingleCellWorkshop)
browseVignettes("SingleCellWorkshop")
```
