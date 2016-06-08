FROM r-base:latest

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

RUN apt-get update -qq \
    && apt-get install -t unstable -y --no-install-recommends \
        libcurl4-openssl-dev \
        libssl-dev \
        libsqlite3-dev \
        libxml2-dev \
        qpdf \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN R -e "install.packages('devtools')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('shinyFiles')"
RUN R -e "devtools::install_github('dimitri-justeau/SSDM')"

ADD load_SSDM_gui.R /load_SSDM_gui.R

CMD Rscript /load_SSDM_gui.R
