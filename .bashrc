# ----------------------
# Input
# ----------------------
echo "set completion-ignore-case on" > ~/.inputrc

# ----------------------
# Load Alias
# ----------------------
if [ -e .http_status_alias.bash ]; then
    . .http_status_alias.bash
fi

if [ -e .git_alias.bash ]; then
    . .git_alias.bash
fi

if [ -e .spark_hadoop_env.bash ]; then
    . .spark_hadoop_env.bash
fi

# Other alias
alias findn='find . -name'
alias diff='diff -u'
alias df='df -Th'
alias py='python'

# Some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
if [ $(uname) = "linux" ]; then
    alias ls='ls --color=auto -AF'
else
    alias ls='ls -GAF'
fi

# Settings for peco
peco-select-history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
    # for OSX
    if [ `uname` = "Darwin" ]; then
        echo ${READLINE_LINE} | pbcopy
    fi
}
bind -x '"\C-r": peco-select-history'

# peco + cd
function peco-cd {
    local dir="$( find . -maxdepth 1 -type d | sed -e 's;\./;;' | peco )"
    if [ ! -z "$dir" ]; then
        cd "$dir"
    fi
}
alias pcd="peco-cd"

# peco + pkill
function peco-pkill() {
    for pid in `ps aux | peco | awk '{ print $2 }'`; do
        kill $pid
        echo "Killed ${pid}"
    done
}
alias ppkill="peco-pkill"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ----------------------
# Terminal
# ----------------------

# Check that terminfo exists before changing TERM var to xterm-256color
# Prevents prompt flashing in Mac OS X 10.6 Terminal.app
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
fi

# Turn off standout; turn off underline
tput sgr 0 0

# Base styles and color palette
# If you want to check color code, run `./testcolor.sh'
BOLD=$(tput bold)
RESET=$(tput sgr0)
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 255)
ORANGE=$(tput setaf 172)

style_user="\[${RESET}${ORANGE}\]"
style_host="\[${RESET}${YELLOW}\]"
style_path="\[${RESET}${GREEN}\]"
style_chars="\[${RESET}${WHITE}\]"
style_branch="${CYAN}"

if [[ "$SSH_TTY" ]]; then
    # connected via ssh
    style_host="\[${BOLD}${RED}\]"
elif [[ "$USER" == "root" ]]; then
    # logged in as root
    style_user="\[${BOLD}${RED}\]"
fi

is_git_repo() {
    $(git rev-parse --is-inside-work-tree &> /dev/null)
}

is_git_dir() {
    $(git rev-parse --is-inside-git-dir 2> /dev/null)
}

get_git_branch() {
    local branch_name

    # Get the short symbolic ref ( Old Linux )
    # branch_name=$(git symbolic-ref --quiet HEAD 2> /dev/null) ||
    # Get the short symbolic ref ( Mac OS )
    branch_name=$(git symbolic-ref --quiet --short HEAD 2> /dev/null) ||
    # If HEAD isn't a symbolic ref, get the short SHA
    branch_name=$(git rev-parse --short HEAD 2> /dev/null) ||
    # Otherwise, just give up
    branch_name="(unknown)"

    printf $branch_name
}

# Git status information
prompt_git() {
    local git_info git_state uc us ut st

    if ! is_git_repo || is_git_dir; then
        return 1
    fi

    git_info=$(get_git_branch)

    # Check for uncommitted changes in the index
    # if ! $(git diff --quiet --ignore-submodules --cached); then
    #     uc="+"
    # fi

    # Check for unstaged changes
    # if ! $(git diff-files --quiet --ignore-submodules --); then
    #     us="!"
    # fi

    # Check for untracked files
    # if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    #     ut="?"
    # fi

    # Check for stashed files
    # if $(git rev-parse --verify refs/stash &>/dev/null); then
    #     st="$"
    # fi

    git_state=$uc$us$ut$st

    # Combine the branch name and state information
    if [[ $git_state ]]; then
        git_info="$git_info[$git_state]"
    fi

    printf "${WHITE} on ${style_branch}${git_info}"
}

# Set the terminal title to the current working directory
PS1="\[\033]0;\w\007\]"
# Build the prompt
PS1+="${style_user}\u" # Username
PS1+="${style_chars}@" # @
PS1+="${style_host}\h" # Host
PS1+="${style_chars}: " # :
PS1+="${style_path}\w" # Working directory
PS1+="\$(prompt_git)" # Git details
PS1+="\n" # Newline
PS1+="${style_chars}\$ \[${RESET}\]" # $ (and reset color)

# ----------------------
# PATH
# ----------------------
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH

# Spark
export PATH=/usr/local/share/spark/bin:$PATH

# Cabal (building and packaging Haskell libraries and programs)
export PATH=~/.cabal/bin:$PATH

# Python
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

# Golang
if [ `uname` = "Darwin" ]; then
    alias df='df -h'
    # for macOS
    export GOPATH=$HOME/dev
    export GOROOT=/usr/local/Cellar/go/1.8.3/libexec
    export PATH=$PATH:$GOROOT/bin
    export PATH=$PATH:$GOPATH/bin
elif [ -e /etc/debian_version ]; then
    # for debian
    export GOPATH=$HOME/dev
    export GOROOT=/root/go
    export GOARCH=arm
    export GOOS=linux
    export PATH=$PATH:$GOROOT/bin
    export PATH=$PATH:$GOPATH/bin
elif [ `uname` = "Linux" ]; then
    echo "using linux"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Node
if [ -e ~/.nvm/nvm.sh ]; then
    source ~/.nvm/nvm.sh
    nvm use 6.2.0
fi

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi
