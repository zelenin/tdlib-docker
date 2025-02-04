FROM alpine:3.20.3 AS tdlib-builder

ENV LANG=en_US.UTF-8
ENV TZ=UTC

ARG TD_COMMIT

RUN apk update && \
    apk upgrade && \
    apk add --update \
        alpine-sdk \
        ca-certificates \
        ccache \
        cmake \
        gperf \
        linux-headers \
        openssl-dev \
        php \
        zlib-dev
RUN git clone "https://github.com/tdlib/td.git" /src && \
    cd /src && \
    git checkout ${TD_COMMIT} && \
    rm -rf build && \
    mkdir ./build
RUN cd /src/build && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX:PATH=/usr/local \
        .. && \
    cmake --build . --target prepare_cross_compiling && \
    cd .. && \
    php SplitSource.php && \
    cd build && \
    cmake --build . --target install


FROM alpine:3.20.3

ENV LANG=en_US.UTF-8
ENV TZ=UTC

WORKDIR /src

COPY --from=tdlib-builder /usr/local/include/td /usr/local/include/td/
COPY --from=tdlib-builder /usr/local/lib/libtd* /usr/local/lib/
