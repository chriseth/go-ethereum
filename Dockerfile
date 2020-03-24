# Build Geth in a stock Go builder container
FROM golang:1.13-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

ADD . /go-ethereum
RUN cd /go-ethereum && make geth

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

WORKDIR /home

RUN apk add --no-cache ca-certificates
RUN apk add bash
COPY --from=builder /go-ethereum/build/bin/geth /usr/local/bin/
COPY --from=builder /go-ethereum/start_geth.sh /home/start_geth.sh

EXPOSE 8545 8546 8547 30303 30303/udp
CMD [ "./start_geth.sh" ]
