FROM messense/rust-musl-cross:x86_64-musl as chef
ENV SQLX_OFFLINE=true
RUN cargo install cargo-chef
WORKDIR /zero2prod

FROM chef as planner
COPY . .
# Compute a lock-like file for our project
RUN cargo chef prepare  --recipe-path recipe.json

FROM chef as builder
COPY --from=planner /app/recipe.json recipe.json
# Build our project dependencies, not our application!
RUN cargo chef cook --release --target x86_64-unknown-linux-musl --recipe-path recipe.json
COPY . .

# Build our project
RUN cargo build --release --target x86_64-unknown-linux-musl

FROM scratch
COPY --from=builder /zero2prod/target/x86_64-unknown-linux-musl/release/zero2prod /zero2prod
ENV APP_ENVIRONMENT production
ENTRYPOINT ["/zero2prod"]
EXPOSE 3000