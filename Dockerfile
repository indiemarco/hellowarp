FROM rust:latest as builder

RUN rustup target add x86_64-unknown-linux-musl
ENV HOME=/home/root
WORKDIR $HOME/app

COPY src src
COPY Cargo.lock .
COPY Cargo.toml .

RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,sharing=private,target=/home/root/app/target \
    cargo install --path . --target x86_64-unknown-linux-musl

FROM alpine
COPY --from=builder /usr/local/cargo/bin/hellowarp .
EXPOSE 8080
USER 1000
CMD ["./hellowarp"]
