FROM rust:1.71.1
WORKDIR /app
RUN apt update && apt install lld clang -y
COPY . .
ENV SQLX_OFFLINE true
# Build our project
RUN cargo build --release --bin zero2prod
ENTRYPOINT ["./target/release/zero2prod"]