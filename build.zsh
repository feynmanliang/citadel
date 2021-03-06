#!/usr/bin/env zsh

# set zsh as default shell
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)

# builds the citadel and castles
git clone https://github.com/andsens/homeshick $HOME/.homesick/repos/homeshick
git clone git://myrepos.branchable.com/ $HOME/.homesick/repos/myrepos
mv ${0:a:h} $HOME/.homesick/repos/citadel

print "Checking out kingdom to ~/.homesick/repos/"
source $HOME/.homesick/repos/homeshick/homeshick.sh
homeshick link
cd $HOME
$HOME/.homesick/repos/myrepos/mr checkout

print "Cloning submodules"
cd $HOME
$HOME/.homesick/repos/myrepos/mr run git submodule init
$HOME/.homesick/repos/myrepos/mr run git submodule update --recursive

print "Symlinking dotfiles to ${HOME}"
homeshick link

# rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash

# install pyenv
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# setup Neovim python venvs
pyenv install 2.7.15
pyenv install 3.6.6
pyenv virtualenv 2.7.15 neovim2
pyenv virtualenv 3.6.6 neovim3
pyenv activate neovim2
pip install neovim
pyenv which python  # Note the path
pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path

# install vim plugins
print "Installing plug.vim"
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
print "Installing vim plugins"
nvim +PlugInstall +qall

# set private key permissions
chmod 0600 $HOME/.ssh/id_rsa

print "The kingdom was successfully built."
print "Citadel now lives in ~/.homeshick/repos/citadel. This directory may now be deleted"
