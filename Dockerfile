FROM golang:1.10-alpine
ARG VERSION=v1.0.0
RUN apk add --update --no-cache git nano tar openssl gcc g++
RUN go get github.com/mitchellh/gox
RUN go get -u github.com/cloudflare/cfssl/cmd/...
WORKDIR /go/src/github.com/cloudflare/cfssl/cmd
RUN CGO_ENABLED=1 gox -osarch="linux/amd64" -ldflags="-w" -output="/build/{{.Dir}}" ./...
WORKDIR /build
FROM hasholding/alpine-base
LABEL maintainer "Levent SAGIROGLU <LSagiroglu@gmail.com>"

VOLUME /shared
COPY --from=0 /build/. /bin/
WORKDIR /shared