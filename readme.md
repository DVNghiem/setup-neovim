# Setup Neovim

## Install vim-plug
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
## Install depend
```bash
:CocInstall coc-pyright
:CocInstall coc-rust-analyzer
sudo npm i -g pyright
sudo npm i -q typescript-language-server
sudo npm i -g vim-language-server
pip3 install pynvim
pip3 install jedi
pip3 insall jedi-language-server

```
