# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

# Install required packages
RUN apt-get update && \
    apt-get install -y curl build-essential clang lld && \
    rm -rf /var/lib/apt/lists/*

# Install Rust using Rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Set the working directory inside the container
WORKDIR /app

# Copy the rest of the application source code to the working directory
COPY . .

# Build your Rust project using lld
RUN cargo build --release --target x86_64-unknown-linux-gnu --locked

# Set the default command to run the application
CMD ["./target/x86_64-unknown-linux-gnu/release/zero2prod"]
