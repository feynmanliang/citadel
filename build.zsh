#!/usr/bin/zsh

# builds the citadel and castles
git clone git@github.com:andsens/homeshick $HOME/.homesick/repos/homeshick
git clone git@github.com:joeyh/myrepos $HOME/.homesick/repos/myrepos
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

# install vim plugins
print "Installing Vundle and plugins"
vim -c "VundleInstall"

# compile YouCompleteMe vim plugin (requires build-essential, cmake, python-dev, python3-dev)
print "Compiling YouCompleteMe"
cd $HOME/.vim/bundle/YouCompleteMe/
./install.py --clang-completer --tern-completer # requires nodejs, npm

# set private key permissions
chmod 0600 $HOME/.ssh/id_rsa

print "The kingdom was successfully built."
print "Citadel now lives in ~/.homeshick/repos/citadel. This directory may now be deleted"
