# README

Inspiration from: https://github.com/Alexis12119/nvim-config/

## Manual labor

[ ] Install nerd fonts in terminal
[ ] Install neovim
[ ] Configure tmux
[ ] Configure neovim


## Windows nerd fonts

Download zip archive

Right click font and install

In windows terminal:

Set startup profile

Go to profile -> appearance -> fonts

## Install neovim

Download deb (or any other file)...

Add to bash_aliases:

```
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias vimdiff="nvim -d"
```

## Configure tmux

Link config with create-links.sh

Restart tmux server

```
tmux kill-server
```

## Configure neovim

Link config with create-links.sh

Install:

```
apt install build-essential
apt install ripgrep #(or https://github.com/BurntSushi/ripgrep)
```

Install ripgrep:


Resolve health checks:

```
:checkhealth
```

## Install 

* go
* rust

