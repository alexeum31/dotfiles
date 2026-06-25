#!/bin/bash

# set zsh as default shell
chsh -s $(which zsh)
echo "Shell changed to zsh — log out and back in for it to take effect"

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

# install packages
sudo apt install -y eza
sudo apt install -y autorandr
sudo apt install pulseaudio-utils brightnessctl # fn keybinds used in i3
sudo apt install htop # CPU profiling
sudo apt install clangd

# symlink configs
ln -sf ~/.dotfiles/i3/config ~/.config/i3/config
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/gdb/gdb-dashboard/.gdbinit ~/.gdbinit
ln -sf ~/.dotfiles/autorandr ~/.config/autorandr
ln -sf ~/.dotfiles/claude/settings.json ~/.claude/settings.json
