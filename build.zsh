#!/usr/bin/env zsh

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
cd $HOME/.homesick/repos/zsh-castle/home/.zprezto/
git submodule init
git submodule update --recursive

print "Symlinking dotfiles to ${HOME}"
homeshick link

# install pyenv
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
export PATH=$HOME/.pyenv/bin:$PATH
eval $(pyenv init -)
eval $(pyenv virtualenv-init -)

# setup Neovim python venvs
pyenv install 2.7.13
pyenv install 3.6.1
pyenv virtualenv 2.7.13 neovim2
pyenv virtualenv 3.6.1 neovim3
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

# rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash

print "The kingdom was successfully built."
print "Citadel now lives in ~/.homeshick/repos/citadel. This directory may now be deleted"
