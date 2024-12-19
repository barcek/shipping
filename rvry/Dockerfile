# specify and use base image

ARG BASE_TAG=alpine:3.21.0

FROM ${BASE_TAG}

# include other dependencies

RUN apk add --no-cache bash ncurses coreutils gawk grep &&\
    ln -sf /usr/bin/gawk /usr/bin/awk

# specify and include rvry

ARG TOOL_VSN=1.24.0
ARG TOOL_CMT=11c894d7cc6958c52318be5c885572c449582471
ARG TOOL_SRC=https://raw.githubusercontent.com/barcek/rvry/${TOOL_CMT}/rvry

RUN wget ${TOOL_SRC} -O /bin/rvry &&\
    chmod +x /bin/rvry

ENV TERM=linux

# switch to non-root user

RUN addgroup --gid 1000 rvry &&\
    adduser  --uid 1000 --disabled-password --ingroup rvry rvry

USER rvry:rvry

# run as PID 1 with default behaviour,
# allowing for any arguments

ENTRYPOINT ["rvry"]
