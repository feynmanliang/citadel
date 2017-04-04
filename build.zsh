#!/usr/bin/env zsh

# builds the citadel and castles
git clone git@github.com:andsens/homeshick $HOME/.homesick/repos/homeshick
git clone https://git.joeyh.name/git/myrepos.git/ $HOME/.homesick/repos/myrepos
git clone git@github.com:feynmanliang/citadel  $HOME/.homesick/repos/citadel

print "Checking out kingdom to ~/.homesick/repos/"
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
source $HOME/.homesick/repos/homeshick/homeshick.sh
homeshick link

# setup Neovim python venvs
pyenv install 2.7.11
pyenv install 3.4.4
pyenv virtualenv 2.7.11 neovim2
pyenv virtualenv 3.4.4 neovim3
pyenv activate neovim2
pip install neovim
pyenv which python  # Note the path
pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path
pip install flake8
ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH

# install vim plugins
print "Installing plug.vim"
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
print "Installing vim plugins"
vim -c "PlugInstall"

# set private key permissions
chmod 0600 $HOME/.ssh/id_rsa

print "The kingdom was successfully built."
print "Citadel now lives in ~/.homeshick/repos/citadel. This directory may now be deleted"
