dotfiles
---

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

* (Option) install plug-in for vim.

```bash
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$ vim
:PluginInstall
```

## Licence
[MIT](http://opensource.org/licenses/MIT)

## Author
[t2sy](https://github.com/fisproject)
