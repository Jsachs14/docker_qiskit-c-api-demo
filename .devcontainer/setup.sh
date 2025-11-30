#!/usr/bin/env bash
set -euo pipefail

ROOT="/workspaces/docker_qiskit-c-api-demo"

echo "=== [setup] Initing submodules ==="
cd "$ROOT"
git submodule update --init --recursive

echo "=== [setup] Building Qiskit C extension (deps/qiskit, make c) ==="
cd "$ROOT/deps/qiskit"
make c

echo "=== [setup] Building QRMI service (deps/qrmi, cargo build --release) ==="
cd "$ROOT/deps/qrmi"
cargo build --release

echo "=== [setup] Configuring and building demo (cmake ..; make) ==="
cd "$ROOT"
mkdir -p build
cd build
cmake .. -DCMAKE_CXX_FLAGS="-DUSE_RANDOM_SHOTS=1"
make -j"$(nproc)"

echo "=== [setup] Running ctest (non-fatal) ==="
ctest || echo '[setup] ctest failed (or tests not configured); continuing.'

echo "=== [setup] Done. Binaries are in build/ ==="
