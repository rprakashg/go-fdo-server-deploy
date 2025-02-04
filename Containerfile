#Define Args
ARG BUILDER_DIGEST
ARG PORT=8038
ARG DB_NAME="mfg.db"
ARG DB_PASS=""

# Define a volume mountpoint for db file
VOLUME [/data]

FROM ghcr.io/rprakashg/go-fdo-server-builder@$BUILDER_DIGEST as builder

FROM registry.access.redhat.com/ubi9/ubi-minimal

WORKDIR /app

COPY --from=builder /app/fdo_server ./fdo_server 

CMD ["fdo_server", "-http", "127.0.0.1:$PORT", "-db", "/data/$DB_NAME", "-db-pass", $DB_PASS, "-debug"]
