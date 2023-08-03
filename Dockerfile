FROM rust:1.59.0
WORKDIR /app
RUN apt update && apt install lld clang -y
COPY . .
ENV SQLX_OFFLINE true
RUN cargo build --release
<<<<<<< HEAD
ENTRYPOINT ["./target/release/zero2prod"]
=======
ENTRYPOINT ["./target/release/zero2prod"]
>>>>>>> 86b8b4b (commit)
