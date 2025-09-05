#!/usr/bin/env bash
set -euo pipefail

echo ">>> Updating package index..."
sudo apt update

echo ">>> Installing DevOps essentials..."
sudo apt install -y \
    ripgrep \
    fd-find \
    bat \
    fzf \
    jq \
    yq \
    silversearcher-ag \
    tree \
    ncdu \
    htop \
    mtr-tiny \
    bmon \
    httpie \
    neovim \
    git tig \
    entr \
    tldr

echo ">>> Installing Rust-based extras via cargo (if available)..."
if command -v cargo >/dev/null 2>&1; then
    cargo install sd broot exa procs gping du-dust navi
else
    echo "Rust (cargo) not found. Install Rust with: curl https://sh.rustup.rs -sSf | sh"
fi

echo ">>> Adding quality-of-life aliases..."
{
    echo "alias cat='batcat --paging=never'"
    echo "alias fd='fdfind'"
    echo "alias rg='rg --smart-case'"
    echo "alias lg='lazygit'"
} >> ~/.bashrc

echo ">>> Done! Run 'source ~/.bashrc' to load aliases."
