FROM iseedevelopers/isee:latest

MAINTAINER kevinrue67@gmail.com
LABEL authors="kevinrue67@gmail.com" \
    description="Docker image containing the iSEE workshop at EuroBioc2020."

WORKDIR /home/rstudio/iseeworkshopeurobioc2020

COPY --chown=rstudio:rstudio . /home/rstudio/iseeworkshopeurobioc2020

ENV R_REMOTES_NO_ERRORS_FROM_WARNINGS=true

RUN apt-get update && \
      apt-get -y install libgit2-dev

RUN Rscript --vanilla -e "options(repos = c(CRAN = 'https://cran.r-project.org')); BiocManager::install(ask=FALSE)"

RUN Rscript --vanilla -e "options(repos = c(CRAN = 'https://cran.r-project.org')); BiocManager::install('usethis')"

RUN Rscript --vanilla -e "options(repos = c(CRAN = 'https://cran.r-project.org')); devtools::install('.', dependencies=TRUE, build_vignettes=TRUE, repos = BiocManager::repositories())"

# The vignette needs to be run as the rstudio user, to store the file in his home folder
USER rstudio

RUN Rscript --vanilla -e "knitr::knit('/home/rstudio/iseeworkshopeurobioc2020/vignettes/dataset.Rmd', tempfile(fileext = '.md'))"

# Seems like root user needs to be active when `docker run` is called
USER root
