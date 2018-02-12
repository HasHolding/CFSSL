FROM golang:1.9.3-alpine
ARG VERSION=v1.0.0
RUN apk add --update --no-cache git nano openssl gcc g++
RUN go get github.com/mitchellh/gox
RUN go get -u github.com/cloudflare/cfssl/cmd/...
WORKDIR /go/src/github.com/cloudflare/cfssl/cmd
RUN CGO_ENABLED=0 gox -osarch="linux/amd64" -ldflags="-w" -output="/exe/{{.Dir}}" ./...
WORKDIR /exe
