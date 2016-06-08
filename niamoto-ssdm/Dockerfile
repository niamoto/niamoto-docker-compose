FROM r-base:latest

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

RUN apt-get update -qq \
    && apt-get install -t unstable -y --no-install-recommends \
        libcurl4-openssl-dev \
        libssl-dev \
        libsqlite3-dev \
        libxml2-dev \
        qpdf \
        vim

RUN apt-get update && apt-get install libgdal-dev libproj-dev

RUN R -e "install.packages('devtools')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('shinyFiles')"
RUN R -e "install.packages('rgdal')"
RUN R -e "devtools::install_github('dimitri-justeau/SSDM')"

ADD load_SSDM_gui.R /load_SSDM_gui.R

CMD Rscript /load_SSDM_gui.R
