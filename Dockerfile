FROM debian:jessie-slim
LABEL maintainer="The Valuto Team <info@valuto.io>"

ARG VALUTO_VERSION="1.0.0"
ENV VALUTO_VERSION $VALUTO_VERSION
ENV VALUTO_PACKAGE="v${VALUTO_VERSION}"
ARG VALUTO_ZIP="${VALUTO_PACKAGE}.tar.gz"
ENV VALUTO_ZIP $VALUTO_ZIP
ARG VALUTO_RELEASE="https://github.com/valuto/valuto/archive/${VALUTO_ZIP}"
ARG VALUTO_DIR="/valuto"
ENV VALUTO_DIR $VALUTO_DIR
ENV VALUTO_DATA_DIR="/valuto-data"

RUN mkdir "$VALUTO_DIR"

RUN apt-get update && apt install -y build-essential libboost-all-dev libcurl4-openssl-dev libdb5.3-dev libdb5.3++-dev libminiupnpc-dev libssl-dev

ADD $VALUTO_RELEASE /

RUN tar zxvf $VALUTO_ZIP -C $VALUTO_DIR --strip 1
RUN mkdir -p "$VALUTO_DIR/src/obj"

# Clean up.
RUN rm "$VALUTO_ZIP" && \
    apt-get autoremove -y && \
    apt-get clean

EXPOSE 40333 41333 40332 41332

WORKDIR "$VALUTO_DIR/src"

# Compile valuto for linux.
RUN make -f makefile.unix

# Make symbolic link from user data directory to the data directory valuto will look for as default.
RUN ln -s /valuto-data /root/.valuto

# Start valutod.
ENTRYPOINT ./valutod
