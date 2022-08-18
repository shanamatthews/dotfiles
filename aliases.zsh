alias myip="curl http://ipecho.net/plain; echo"
alias aliases="vim ~/src/git/dotfiles/aliases.zsh"
alias c=clear
alias top=htop

alias ubuntu="docker run -it --rm ubuntu"

alias shellcheck='function _sc(){ shellcheck -o all $1; }; _sc'
alias sc='function _sc(){ shellcheck -o all $1; }; _sc'

alias snippets='cd $SNIPPETS'
alias scripts='cd $SCRIPTS'
alias vip='vim -p'

alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'

alias tx='tmux attach || tmux new -s mysesh'
# ------------------------------ bash ls aliases -----------------------------
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# basic ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


