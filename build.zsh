#!/usr/bin/zsh

# builds the citadel and castles
mkdir -p ~/.homesick/repos/
cd ~/.homesick/repos
git clone https://github.com/feynmanliang/citadel 
cd citadel

source ./homeshick/homeshick.sh
homeshick link
./myrepos/mr checkout
homeshick link

# install vim plugins
vim -c "VundleInstall"

# compile YouCompleteMe vim plugin (requires build-essential, cmake, python-dev, python3-dev)
cd ~/.vim/bundle/YouCompleteMe/
./install.py --clang-completer --tern-completer # requires nodejs, npm

print "Built citadel and castles undr ~/.homesick/repos. It is now OK to remove this directory"
