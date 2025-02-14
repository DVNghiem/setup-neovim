#!/bin/bash

sudo dnf install fd-find
sudo dnf install fzf
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit

sudo dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:justkidding/Fedora_41/home:justkidding.repo
sudo dnf install ueberzugpp

sudo dnf install ImageMagick-devel

sudo dnf install chafa

