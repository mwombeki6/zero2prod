# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables
#ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Rust using Rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Set Rust environment variables
ENV PATH="/root/.cargo/bin:$PATH"

# Set the working directory inside the container
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files to the working directory
COPY Cargo.toml Cargo.lock ./

# Build and cache the dependencies
RUN cargo build --target x86_64-unknown-linux-gnu --release

# Copy the rest of the application source code to the working directory
COPY . .

# Build the application
RUN cargo build --target x86_64-unknown-linux-gnu --release

# Set the default command to run the application
CMD ["./target/x86_64-unknown-linux-gnu/release/zero2prod"]
