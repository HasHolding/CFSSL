FROM golang:1.10-alpine
ARG VERSION=1.3.2
RUN apk add --update --no-cache git nano curl tar openssl gcc g++
RUN go get github.com/mitchellh/gox
RUN mkdir -p /go/src/github.com/cloudflare/cfssl
WORKDIR /go/src/github.com/cloudflare/cfssl/
RUN curl -sSL https://github.com/cloudflare/cfssl/archive/${VERSION}.tar.gz | tar xz --strip 1
WORKDIR /go/src/github.com/cloudflare/cfssl/cmd
RUN CGO_ENABLED=1 gox -osarch="linux/amd64" -ldflags="-w" -output="/build/{{.Dir}}" ./...
#----------------
FROM hasholding/alpine-base
LABEL maintainer "Levent SAGIROGLU <LSagiroglu@gmail.com>"
VOLUME /shared
COPY --from=0 /build/. /bin/
WORKDIR /shared