#!/bin/bash


curl -LO https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.tar.gz 
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz 
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz

sudo dnf install fd-find -y
sudo dnf install fzf -y
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit -y
sudo dnf install chafa -y

