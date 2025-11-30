FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Basic build + math/HPC deps
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip \
    libopenblas-dev \
    libopenmpi-dev \
    openmpi-bin \
    libeigen3-dev \
    curl \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Rust (stable) for qiskit, qrmi, etc.
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

# Rust binaries on PATH
ENV PATH=/root/.cargo/bin:${PATH}

# Tell pyo3 / qiskit which Python to bind against
ENV PYO3_PYTHON=/usr/bin/python3

# Default working dir when the container starts
WORKDIR /workspaces/docker_qiskit-c-api-demo
