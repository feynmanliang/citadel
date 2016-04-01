#!/usr/bin/zsh

# builds the citadel and castles
git clone https://github.com/andsens/homeshick $HOME/.homesick/repos/homeshick
git clone https://github.com/joeyh/myrepos $HOME/.homesick/repos/myrepos
git clone https://github.com/feynmanliang/citadel  $HOME/.homesick/repos/citadel

print "Checking out kingdom to ~/.homesick/repos/"
$HOME/.homesick/repos/myrepos/mr checkout


print "Symlinking dotfiles to ${HOME}"
source $HOME/.homesick/repos/homeshick/homeshick.sh
homeshick link

# install vim plugins
print "Installing Vundle plugins"
vim -c "VundleInstall"


# compile YouCompleteMe vim plugin (requires build-essential, cmake, python-dev, python3-dev)
print "Compiling YouCompleteMe"
cd ~/.vim/bundle/YouCompleteMe/
./install.py --clang-completer --tern-completer # requires nodejs, npm

print "The kingdom was successfully built."
