FROM rust:1.72.1 as builder

WORKDIR /usr/src/trusty
COPY . .
# RUN cargo install --target x86_64-unknown-linux-gnu --path .
RUN cargo install --path .


# FROM debian:bullseye
FROM debian:bookworm-slim
LABEL org.opencontainers.image.source=https://github.com/master-in-science/trusty

RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/trusty /usr/local/bin/trusty
RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates

ENTRYPOINT ["trusty"]
