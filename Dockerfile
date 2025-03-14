
FROM rocker/rstudio:4.4.0

RUN apt-get update && \
    apt-get install -y \
        libhdf5-dev \
        libcurl4-gnutls-dev \
        libssl-dev \
        libxml2-dev \
        libpng-dev \
        libxt-dev \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev \
        libglpk40 \
        libgit2-dev \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "options(warn=2); install.packages(c('BiocManager'))"
RUN Rscript -e "options(warn=2); BiocManager::install(version = '3.20')"
RUN Rscript -e "options(warn=2); BiocManager::install(c('Herper'))"

RUN mkdir /home/miniconda
RUN Rscript -e "options(warn=2); Herper::install_CondaTools(tools = 'salmon', env = 'pipe_env', pathToMiniConda = '/home/miniconda')"


EXPOSE 8787

CMD ["/init"]


