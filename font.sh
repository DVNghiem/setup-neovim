#!/bin/bash

mkdir -p ~/.local/share/fonts
curl -fLo ~/.local/share/fonts/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip ~/.local/share/fonts/JetBrainsMono.zip -d ~/.local/share/fonts/
rm ~/.local/share/fonts/JetBrainsMono.zip
fc-cache -fv