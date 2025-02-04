FROM golang:1.23 AS builder

RUN mkdir /app & \
    git clone https://github.com/fido-device-onboard/go-fdo-server.git /app

WORKDIR /app

RUN go mod download 

RUN ./update-deps.sh

RUN CGO_ENABLED=0 go build -o fdo_server ./cmd/fdo_server/