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

vim -c "VundleInstall"
