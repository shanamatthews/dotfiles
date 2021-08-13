# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;; # interactive
      *) return;; # do nothing
esac

# ---------------------------- environment variables ---------------------------
export TERM=xterm-256color
export EDITOR=vim
export VISUAL=vim
export SCRIPTS="$HOME/.local/bin"
export SNIPPETS="$HOME/.local/snippets"

# ------------------------------------ pager -----------------------------------
# this is how we get colored man pages oooooh so fancy
# no one honestly knows what most of this does but it does make it pretty
# these variables are designed so that man will work with them

if test -x /usr/bin/lesspipe; then
  export LESSOPEN="| /usr/bin/lesspipe %s";
  export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi

export LESS_TERMCAP_mb="^[[35m"   # magenta
export LESS_TERMCAP_md="^[[33m"  # yellow
export LESS_TERMCAP_me=""
export LESS_TERMCAP_se=""
export LESS_TERMCAP_so="^[[34m"  # blue
export LESS_TERMCAP_ue=""
export LESS_TERMCAP_us="^[[4m"   # underline

# this is broken
# export MANPAGER="less -R --use-color -Dd+r -Du+b"

# ----------------------------------- dircolors ---------------------------------

if command -v dircolors &> /dev/null; then # check if our system has dircolors (which ones dont't??)
  if test -r ~/.config/ls/dircolors; then
    eval "$(dircolors -b ~/.config/ls/dircolors)"    # support custom dircolors
  else
    eval "$(dircolors -b)"
  fi
fi

alias ls='ls -h --color=auto'              # -h for human-readable output

# ------------------------------ bash shell options -----------------------------

shopt -s globstar
set -o noclobber

# because its bae
set -o vi

# keep history between sessions
shopt -s histappend

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

# ------------------------------------ prompt ------------------------------------

__ps1() {
  # \u for user
  # \W for short working directory
  # date=$(date)
  export PS1='\[\e[33m\]\u\[\e[30m\]@\[\e[34m\]\W\[\e[33m\]\$\[\e[0m\] '
  # export PS1='\[\e[33m\]\u\[\e[30m\]@\[\e[34m\]\W\[\e[33m\]\$\[\e[0m\] '$(date)' '
}

PROMPT_COMMAND="__ps1"

# ------------------------------------ aliases -----------------------------------

alias more='less'
alias scripts='cd ${SCRIPTS}'
#!/usr/bin/bash

# ---------------------------------- functions -----------------------------------

cdtmp() {
  name="$1"
  mkdir -p "/tmp/$name"
  cd "/tmp/$name"
}

# -------------------------------- tab completion  -------------------------------

owncomp=(isosec)
for i in ${owncomp[@]}; do complete -C $i $i; done

# ------------------------------------ PATH  -------------------------------------

pathappend() {
  declare arg
  for arg in "$@"; do
    test -d "${arg}" || continue    # if the directory doesn't exist, don't bother
    if test "${arg}" = "." ; then
      echo "Don't do that"
      continue
    fi
    PATH=${PATH//:${arg}/}        # if the directory is already in the path, remove it
    PATH=${PATH#${arg}:}        # if the directory is already in the path, first thing on the path, remove it
    export PATH="${PATH:+"${PATH}:"}${arg}"
  done
}

pathprepend() {
  declare arg
  for arg in "$@"; do
    test -d "${arg}" || continue    # if the directory doesn't exist, don't bother
    if test "${arg}" = "." ; then
      echo "Don't do that"
      continue
    fi
    PATH=${PATH//:${arg}/}        # if the directory is already in the path, remove it
    PATH=${PATH#${arg}:}        # if the directory is already in the path, first thing on the path, remove it
    export PATH="${arg}:${PATH:+"${PATH}"}"
  done
}

pathprepend "$SCRIPTS"
pathprepend "$SNIPPETS"
# export PATH="$SCRIPTS:$PATH"

# ----------------------------------- CDPATH  ------------------------------------

# export CDPATH="$SCRIPTS:$CDPATH"
# export CDPATH=~/.local:"$CDPATH"

CDPATH=.:\
"$SCRIPTS":\
"$SNIPPETS":\
~/.local:\
~
