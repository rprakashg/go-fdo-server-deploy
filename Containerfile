#Define Args
ARG PORT=8038
ARG DB_NAME="mfg.db"
ARG DB_PASS=""

# Define a volume mountpoint for db file
VOLUME [/data]

FROM golang:1.23 AS builder

RUN mkdir /app & \
    git clone https://github.com/fido-device-onboard/go-fdo-server.git /app

WORKDIR /app

RUN go mod download 

RUN ./update-deps.sh

RUN CGO_ENABLED=0 go build -o fdo_server ./cmd/fdo_server/

FROM registry.access.redhat.com/ubi9/ubi-minimal

WORKDIR /app

COPY --from=builder /app/fdo_server ./fdo_server 

CMD ["fdo_server", "-http", "127.0.0.1:$PORT", "-db", "/data/$DB_NAME", "-db-pass", $DB_PASS, "-debug"]
