#!/usr/bin/env bash
set -e

KERNEL_REPO="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
SRC_DIR="$HOME/src/linux"
PERF_DIR="$SRC_DIR/tools/perf"

echo "[1/4] Installing build dependencies..."

sudo apt update
sudo apt install -y \
    build-essential \
    flex bison \
    libelf-dev \
    libdw-dev \
    libunwind-dev \
    libssl-dev \
    pkg-config \
    python3-dev \
    zlib1g-dev \
    liblzma-dev \
    libzstd-dev

echo "[2/4] Cloning/updating Linux source..."

if [ -d "$SRC_DIR/.git" ]; then
    git -C "$SRC_DIR" pull --depth 1
else
    git clone --depth 1 "$KERNEL_REPO" "$SRC_DIR"
fi

echo "[3/4] Building perf..."

make -C "$PERF_DIR" -j"$(nproc)"

echo "[4/4] Installing perf binary..."

sudo install -m 755 "$PERF_DIR/perf" /usr/local/bin/perf

echo "✅ perf installed successfully"
echo ""
echo "👉 Add this to your shell config if not already present:"
echo ""
echo "export PERF_SRC=\"$PERF_DIR\""
echo "alias perf=\"\$PERF_SRC/perf\""
echo ""
echo "Then reload shell:"
echo "  source ~/.zshrc"
