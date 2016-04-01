#!/usr/bin/zsh

# builds the citadel and castles
git clone https://github.com/andsens/homeshick $HOME/.homesick/repos/homesick
git clone https://github.com/joeyh/myrepos $HOME/.homesick/repos/myrepos
git clone https://github.com/feynmanliang/citadel  $HOME/.homesick/repos/citadel

# $HOME/.homesick/repos/myre
# source $HOME/.homesick/repos/homeshick/homeshick.sh
# homeshick link
# ./myrepos/mr checkout
# homeshick link

# # install vim plugins
# vim -c "VundleInstall"

# # compile YouCompleteMe vim plugin (requires build-essential, cmake, python-dev, python3-dev)
# cd ~/.vim/bundle/YouCompleteMe/
# ./install.py --clang-completer --tern-completer # requires nodejs, npm

print "Built citadel and castles undr ~/.homesick/repos. It is now OK to remove this directory"
