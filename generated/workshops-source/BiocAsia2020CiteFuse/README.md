
# Multimodal analysis of CITE-seq data with CiteFuse

## Overview

### Instructors and contact information

- Yingxin Lin (yingxin.lin@sydney.edu.au)
- Hani Jieun Kim (hani.kim@sydney.edu.au)

### Description

The latest breakthrough in single-cell omics is on multi-modal profiling of different biomolecule species in individual cells. Among the fast evolving biotechnologies developed for multi-modal profiling, cellular indexing of transcriptomes and epitopes by sequencing (CITE-seq) is attracting attention, especially in the field of immunology, given its ability to simultaneously quantify global gene expression and cellular proteins using RNA-sequencing and antibody-derived tags (ADTs) on single cells. While the additional protein marker information brought about by ADTs is extremely valuable, new biological insights can only be gained by developing analytic methods that fully take advantage of the complementarity between mRNA and ADT expression measured in CITE-seq.

To address this, we developed a streamlined pipeline–CiteFuse–that consists of a suite of tools for the integration and the downstream analysis of CITE-seq data. In this workshop, we will provide a hands-on experience to the CiteFuse package and cover all the steps including doublet detection, modality integration, cell type clustering, differential RNA and ADT expression analysis, ADT evaluation, and ligand–receptor interaction analysis on a publicly available CITE-seq dataset. We also demonstrate the applicability of CiteFuse package on other multi-modal data types by applying our pipeline on the recently developed ASAP-seq data. 

[This vignette](https://sydneybiox.github.io/CiteFuse/articles/CiteFuse.html) provides a more complete description of the various tools in CiteFuse and will serve as the basis of our workshop.

### Pre-requisites

Software:

* Basic knowledge of R syntax
* Familiarity with single-cell RNA-sequencing
* Familiarity with the `SingleCellExperiment` class

Background reading:

* The textbook "Orchestrating Single-Cell Analysis with Bioconductor" is a great reference for single-cell analysis using Bioconductor packages.
* [CiteFuse enables multi-modal analysis of CITE-seq data](https://academic.oup.com/bioinformatics/article-abstract/36/14/4137/5827474?redirectedFrom=fulltext)
* [Simultaneous epitope and transcriptome measurement in single cells](https://www.nature.com/articles/nmeth.4380)

### Participation

The workshop will start with an introduction to the CITE-seq technology and the dataset using presentation slides. Following this, we will have a lab session on how one may process and integrate multi-modal data and perform downstream analysis involving differential expression, ADT importance evaluation, and ligand-receptor interaction analysis.

### _R_ / _Bioconductor_ packages used

* This workshop will focus on Bioconductor packages [SingleCellExperiment] (https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) and  [CiteFuse](https://academic.oup.com/bioinformatics/article-abstract/36/14/4137/5827474?redirectedFrom=fulltext). 

### Time outline

An example for a 55-minute workshop:

| Activity                            | Time |
|-------------------------------------|------|
| Introduction                        | 15m  |
| Data processing and integration     | 15m  |
| Downstream analysis                 | 15m  |
| Wrap-up and Conclusions             | 5m   |


## Workshop goals and objectives

Participants will learn how to process and apply multi-modal single-cell RNA-seq data and how they can be used for interpretation of complex scRNA-seq datasets. 

### Learning goals

Some examples:

* Reason about complex biological systems
* Grasp the complexity of analyzing biological data where two or more modalities are captured
* Understand the concept of multi-modal analysis of single-cell data

### Learning objectives

* Learn how to analyze single-cell RNA-seq data using Bioconductor packages
* Import and explore multi-modal scRNA-seq datasets
* Understand the challenges of multi-modal data analysis 
* Perform integration of two modalities and clustering of the resulting fused matrix
* Assess the added complexity or even benefit of handling multi-modal data from single cells
* Discuss how the analysis pipeline has incorporated this extra information. How may it further take advantage of the multi-modal data?
