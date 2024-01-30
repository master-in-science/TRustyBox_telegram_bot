FROM rust:1.72.1 as builder
# RUN apt-get update -y
# RUN apt-get upgrade -y
# RUN apt-get install -y pkg-config libssl-dev musl-tools
WORKDIR /usr/src/trusty
COPY . .
# RUN cargo install --target x86_64-unknown-linux-gnu --path .
RUN cargo install --path .

# FROM debian:bullseye
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*
# FROM rust:1.64.0-alpine
COPY --from=builder /usr/local/cargo/bin/trusty /usr/local/bin/trusty
# COPY --from=builder /usr/src/trusty/Config.toml /root/.config/trusty/Config.toml
# Install CA files from linux host to the container
RUN apt-get update
RUN apt-get install -y ca-certificates
RUN update-ca-certificates
# RUN mkdir -p /etc/ssl/certs
# COPY /etc/ssl/certs/DigiCert* /etc/ssl/certs/
ENTRYPOINT ["trusty"]
