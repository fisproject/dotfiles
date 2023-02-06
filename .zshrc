# .zshrc

# ---------------------------
# Input
# ---------------------------
echo "set completion-ignore-case on" > ~/.inputrc

# ---------------------------
# Load aliases and functions
# ---------------------------
if [ -f ~/.http_status_alias.bash ]; then
    source ~/.http_status_alias.bash
fi

if [ -f ~/.git_alias.bash ]; then
    source ~/.git_alias.bash
fi

# ---------------------------
# Basic aliases and functions
# ---------------------------
alias findn='find . -name'
alias diff='diff -u'
alias df='df -Th'
alias py='python'
alias t='trans -b'
alias tj='trans -b -t en -s ja'

# Some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
if [ $(uname) = "linux" ]; then
    alias ls='ls -aF --color=auto'
else
    alias ls='ls -GAF'
fi

# -----------------------------
# Terminal
# -----------------------------

if [ -f ~/.zsh/git-prompt.sh ]; then
    source ~/.zsh/git-prompt.sh

    fpath=(~/.zsh $fpath)
    zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
    autoload -Uz compinit && compinit

    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUPSTREAM=auto

    setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f\$ '
fi

# -----------------------------
# Basic Environmental Variables
# -----------------------------
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=10000

# Python
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$HOME/.local/bin:$PATH"
