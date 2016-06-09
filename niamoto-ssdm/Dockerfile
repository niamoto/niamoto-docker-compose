FROM r-base:latest

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

RUN apt-get update \
    && apt-get install -t unstable -y --no-install-recommends \
        libcurl4-openssl-dev \
        libssl-dev \
        libsqlite3-dev \
        libxml2-dev \
        qpdf \
        vim

# Install gdal and proj
RUN apt-get install -y libgdal-dev libproj-dev

# Install Java.
RUN apt-get install -y default-jdk default-jre
RUN R CMD javareconf

RUN R -e "install.packages('devtools')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('shinyFiles')"
RUN R -e "install.packages('rgdal')"
RUN echo "install.packages('rJava', repos='http://www.rforge.net/', configure.args='--disable-Xrs')" | R --no-save
RUN R -e "devtools::install_github('dimitri-justeau/SSDM')"

ADD maxent.jar /usr/local/lib/R/site-library/dismo/java/maxent.jar

ADD load_SSDM_gui.R /load_SSDM_gui.R

CMD Rscript /load_SSDM_gui.R
