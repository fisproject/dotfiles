#!/bin/bash

dotfiles=( .??* )
scripts=( bin/??* )
targets=( ${dotfiles[*]} ${scripts[*]} )

if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi

# install dotfiles and scripts used by tmux
for f in ${targets[*]}; do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".bashrc_remote" ]] && continue

  if [ -f $HOME/$f ]; then
    echo "$HOME/$f already exists."
  else
    ln -s $PWD/$f $HOME/$f
    echo "link $f to $HOME/$f"
  fi
done
