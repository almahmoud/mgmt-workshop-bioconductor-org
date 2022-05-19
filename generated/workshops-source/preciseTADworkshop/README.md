# preciseTAD: A machine learning framework for precise 3D domain boundary prediction at base-level resolution

The [preciseTADworkshop](https://github.com/dozmorovlab/preciseTADworkshop) introduces methods for transforming the identification of boundaries that demarcate Topologically Associating Domains (TADs)-- referred to as TAD-calling--into a supervised machine learning framework. Chromosome conformation capture technologies combined with high-throughput sequencing (Hi-C) have revealed that chromatin undergoes layers of compaction through DNA looping and folding, forming dynamic 3-dimensional (3D) structures. Among these are TADs, which are known to play critical roles in cell dynamics like gene regulation and cell differentiation. However, precise TAD-calling remains difficult, as it is strongly reliant on Hi-C data resolution. Obtaining genome-wide chromatin interactions at high-resolution is costly resulting in low resolution of Hi-C matrices and high uncertainty in the location of domain boundaries. In this workshop we will circumvent this resolution restriction by building predictive models that leverage high resolution functional genomic element data (ChIP-seq). As an application, we will demonstrate that these methods provide more precise boundary detection compared to a conventional TAD-calling algorithm by evaluating a variety of visualization techniques in relation to the enrichment of key molecular drivers of 3D chromatin. The methods discussed in this workshop will give users tools for bridging the resolution gap between 1D ChIP-seq annotations and 3D Hi-C sequencing data for more precise and biologically meaningful boundary identification.

This workshop is based on [Spiro C. Stilianoudakis, Mikhail G. Dozmorov; "preciseTAD: A machine learning framework for precise 3D domain boundary prediction at base-level resolution"](https://doi.org/10.1101/2020.09.03.282186). 

Key materials for the workshop: 

- [Slides with a brief introduction for the workshop](https://stilianoudakis.github.io/slides_preciseTADworkshop/#1)
- [preciseTADworkshop GitHub repo](https://github.com/dozmorovlab/preciseTADworkshop)
- [preciseTADworkshop Docker image](https://hub.docker.com/repository/docker/stilianoudakis/precisetadworkshop)
- [preciseTADworkshop pkgdown website](https://dozmorovlab.github.io/preciseTADworkshop/)

This workshop will be presented at the [European Bioconductor Virtual Conference 2020](https://eurobioc2020.bioconductor.org/), December 6th, 2020, 5:30pm-6:15pm

# Using Docker

- Pull the latest version of the `preciseTADworkshop` Docker image, `docker pull stilianoudakis/precisetadworkshop:latest`
- Run `docker run -e PASSWORD=yourpassword -p 8787:8787 -d --rm stilianoudakis/precisetadworkshop:latest`. Use `-v $(pwd):/home/rstudio` argument to map your local directory to the container. 
- Log in to RStudio at [http://localhost:8787](http://localhost:8787) using username `rstudio` and password `yourpassword`. Note that on Windows you need to provide your localhost IP address like `http://191.163.92.108:8787/` - find it using `docker-machine ip default` in Docker's terminal.
- Run `browseVignettes(package = "preciseTADworkshop")`. Click on one of the links, "HTML", "source", "R code".

# Local Installation

```
if(!require(devtools)) install.packages("devtools")
devtools::install_github(repo = "dozmorovlab/preciseTADworkshop", build_vignettes = TRUE)
```

If installation fails due to missing packages, install them as follows:

```
if(!require(BiocManager)) install.packages("BiocManager")
BiocManager::install(c('preciseTAD', 'preciseTADhub'))
```

# Workshop Description

## Contact information

- Spiro Stilianoudakis (stilianoudasc@vcu.edu)
- Mikhail Dozmorov (mikhail.dozmorov@vcuhealth.org)

## Pre-requisites

* Basic knowledge of R syntax and command-line tools
* Familiarity with Hi-C chromatin conformation capture technology
* Understanding of Hi-C data properties (contact matrices, interaction frequencies, Topologically Associating Domains, etc)
* Familiarity with TAD-callers, specifically [Arrowhead](https://github.com/aidenlab/juicer/wiki/Arrowhead)
* Familiarity with supervised machine learning techniques (e.g. classification) and clustering algorithms

# R / Bioconductor packages used

* [preciseTAD](https://www.bioconductor.org/packages/preciseTAD)
* [preciseTADhub](https://github.com/dozmorovlab/preciseTADhub)

## Time outline

The workshop duration is ~45 min. The approximate timing of activities are shown below:

| Activity                                              | Time |
|-------------------------------------------------------|------|
| Overview of *preciseTAD*                              | 10m  |
| Model building                                        | 15m  |
| Precise domain boundary prediction                    | 15m  |
| Questions and answers session                         | 5m   |

### Learning Goals

* Get familiar with Hi-C data 
* Understand to transform TAD boundary prediction into a supervised machine learning framework
* Build a predictive model using functional genomic elements
* Predict TAD boundaries at base-level resolution
* Understand and compare results using a variety of different vizualization techniques including enriched heatmaps, signal profile plots, and venn diagrams

