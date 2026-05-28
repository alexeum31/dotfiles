#!/bin/bash

# set zsh as default shell
chsh -s $(which zsh)
echo "Shell changed to zsh — log out and back in for it to take effect"

# symlink configs
ln -sf ~/.dotfiles/i3/config ~/.config/i3/config

# submodules (zsh plugins)
git submodule update --init --recursive

# nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# eza
sudo apt install -y eza
