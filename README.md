dotfiles
===

## Overview

* Utility to install the following dot-files.
  - .bashrc
  - .gitconfig
  - .vimrc
  - .tmux.conf
  - .gitignore
  - .http_status_alias.bash
  - .git_alias.bash
  - .spark_hadoop_env.bash

## Install

```bash
$ git clone https://github.com/fisproject/dotfiles
$ cd dotfiles
$ ./install.sh
```

* Optional: Install plug-in for vim with [vim-plug](https://github.com/junegunn/vim-plug).

```bash
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ vim
:PlugInstall
```

## Licence

[MIT](http://opensource.org/licenses/MIT)

## Author

[t2sy](https://github.com/fisproject)
