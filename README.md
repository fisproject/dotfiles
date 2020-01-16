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

### vim-plug

* **Optional**: Install plug-in for vim with [vim-plug](https://github.com/junegunn/vim-plug).

```bash
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ vim
:PlugInstall
```

### Language Server

* **Optional**: Install [Language Server](https://langserver.org/) for each language.
  - [bash-language-server](https://github.com/mads-hartmann/bash-language-server)
  - [gopls](https://github.com/golang/tools/tree/master/gopls)

## Licence

[MIT](http://opensource.org/licenses/MIT)

## Author

[t2sy](https://github.com/fisproject)
