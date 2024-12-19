# specify and use base image

ARG BASE_TAG=denoland/deno:alpine-2.1.4

FROM ${BASE_TAG}

# include other dependencies

RUN apk add --no-cache bash coreutils gawk grep &&\
    ln -sf /usr/bin/gawk /usr/bin/awk

# specify and include deye

ARG TOOL_VSN=1.14.0
ARG TOOL_CMT=a42962feda3b56ed78192659b020d7ad277c2add
ARG TOOL_SRC=https://raw.githubusercontent.com/barcek/deye/${TOOL_CMT}/deye

RUN wget ${TOOL_SRC} -O /bin/deye &&\
    chmod +x /bin/deye
