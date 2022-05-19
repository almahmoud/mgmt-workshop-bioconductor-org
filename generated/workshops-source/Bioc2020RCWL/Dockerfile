FROM bioconductor/bioconductor_docker:devel

WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN apt-get update && \
    apt-get install -y libglpk-dev python3-pip python3-dev build-essential libssl-dev libssh2-1-dev uuid-dev libgpgme11-dev squashfs-tools libseccomp-dev wget pkg-config git cryptsetup bwa samtools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://golang.org/dl/go1.14.4.linux-amd64.tar.gz && tar xf go1.14.4.linux-amd64.tar.gz -C /opt && rm go1.14.4.linux-amd64.tar.gz
ENV PATH=/opt/go/bin:$PATH
RUN wget https://github.com/hpcng/singularity/releases/download/v3.5.3/singularity-3.5.3.tar.gz && tar xf singularity-3.5.3.tar.gz && \
    cd singularity && export VERSION=3.5.3 && ./mconfig && make -C builddir && make -C builddir install
RUN rm singularity-3.5.3.tar.gz && rm -r singularity

RUN mkdir /opt/STAR && wget https://github.com/alexdobin/STAR/raw/master/bin/Linux_x86_64/STAR -P /opt/STAR/
RUN wget https://github.com/alexdobin/STAR/raw/master/bin/Linux_x86_64/STARlong -P /opt/STAR/ && chmod +x /opt/STAR/*
ENV PATH=/opt/STAR:$PATH

RUN rm -r /usr/local/lib/python2.7/dist-packages/cwltool & rm /usr/local/bin/cwltool
RUN pip3 install -I cwltool
RUN sed -i 's/_SINGULARITY_VERSION = ""/_SINGULARITY_VERSION = "3.5.3"/' /usr/local/lib/python3.8/dist-packages/cwltool/singularity.py

RUN Rscript -e "install.packages(c('Rcpp', 'pkgbuild', 'git2r'), repos='http://cran.r-project.org')"
RUN Rscript -e "devtools::install('.', dependencies=TRUE, build_vignettes=TRUE, repos = BiocManager::repositories())"
RUN git clone https://github.com/hubentu/testdata.git inst/testdata
