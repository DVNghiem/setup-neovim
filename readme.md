# Setup Neovim

## Install vim-plug
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
## Install dependency
1. Install font, icon <a href = "https://github.com/ryanoasis/nerd-fonts">Link</a>
2. Install font manager: <a href="https://itsfoss.com/font-manager/">Link</a>
3. Install depend libs
```bash
:CocInstall coc-pyright
:CocInstall coc-rust-analyzer
:CocInstall coc-prettier
sudo npm i -g pyright
sudo npm i -q typescript-language-server
sudo npm i -g vim-language-server
pip3 install pynvim
pip3 install jedi
pip3 install jedi-language-server
```
