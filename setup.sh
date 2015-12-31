#!/bin/bash
set -ex
files=( .gitconfig .gvimrc .tigrc .tmux.conf .vimrc .zshrc .ghci )

umask g-w,o-w

# Create symlinks
pushd ~
  for file in ${files[@]}; do
    # Create backup files unless backups already exists.
    if [[ -e "$file" && ! -e "${file}.bak" ]]; then
      cp -f "$file" "${file}.bak"
    fi
  
    ln -s --force "dotfiles/$file" .
  done
popd

# Get oh-my-zsh to ~/.oh-my-zsh/
# refs. https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
if [[ ! -d ~/.oh-my-zsh/ ]]; then
    echo Getting oh-my-zsh to ~/.oh-my-zsh/
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    echo Finished to get oh-my-zsh
else
    echo oh-my-zsh is already installed!!
fi

# Show notes
echo run "chsh -s /usr/bin/zsh" if you use zsh

