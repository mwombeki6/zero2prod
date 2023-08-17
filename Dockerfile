# Use the official Rust image as the base image
FROM rust:1.71.1 AS build

# Set the working directory inside the container
WORKDIR /usr/src/zero2prod

# Copy the project files into the container
COPY . .

# Build the Rust project using the stable-x86_64-unknown-linux-gnu target
RUN cargo build --release --target=x86_64-unknown-linux-gnu

# Create a new image with only the built application
FROM debian:buster-slim
WORKDIR /app

# Copy the built binary from the previous stage
COPY --from=build /usr/src/zero2prod/target/x86_64-unknown-linux-gnu/release/zero2prod /app

# Run the binary when the container starts
CMD ["./zero2prod"]
