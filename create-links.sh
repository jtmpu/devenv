#!/bin/bash

MY_PATH="$(dirname -- "${BASH_SOURCE[0]}")"            # relative
MY_PATH="$(cd -- "$MY_PATH" && pwd)"    # absolutized and normalized
if [[ -z "$MY_PATH" ]] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

ln -s $MY_PATH/.tmux.conf $HOME/.tmux.conf
mkdir -p $HOME/.config
ln -s $MY_PATH/nvim $HOME/.config/nvim
