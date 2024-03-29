# ------------------------------ oh-my-zsh stuff -----------------------------

# Path to your oh-my-zsh installation.
export ZSH="/Users/shanamatthews/.oh-my-zsh"
export IS_OMZ=false

if [[ -d "$ZSH" ]]; then
  IS_OMZ=true
fi

if [[ "$IS_OMZ" = true ]]; then
  export ZSH_2000_DISABLE_RVM='true'

  # Set name of the theme to load --- if set to "random", it will
  # load a random theme each time oh-my-zsh is loaded, in which case,
  # to know which specific one was loaded, run: echo $RANDOM_THEME
  # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
  ZSH_THEME="zsh2000"

  # Set list of themes to pick from when loading at random
  # Setting this variable when ZSH_THEME=random will cause zsh to load
  # a theme from this variable instead of looking in $ZSH/themes/
  # If set to an empty array, this variable will have no effect.
  # ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

  # Uncomment the following line to use case-sensitive completion.
  # CASE_SENSITIVE="true"

  # Uncomment the following line to use hyphen-insensitive completion.
  # Case-sensitive completion must be off. _ and - will be interchangeable.
  HYPHEN_INSENSITIVE="true"

  # Uncomment the following line to disable bi-weekly auto-update checks.
  # DISABLE_AUTO_UPDATE="true"

  # Uncomment the following line to automatically update without prompting.
  # DISABLE_UPDATE_PROMPT="true"

  # Uncomment the following line to change how often to auto-update (in days).
  # export UPDATE_ZSH_DAYS=13

  # Uncomment the following line if pasting URLs and other text is messed up.
  # DISABLE_MAGIC_FUNCTIONS="true"

  # Uncomment the following line to disable colors in ls.
  # DISABLE_LS_COLORS="true"

  # Uncomment the following line to disable auto-setting terminal title.
  # DISABLE_AUTO_TITLE="true"

  # Uncomment the following line to enable command auto-correction.
  ENABLE_CORRECTION="true"

  # Uncomment the following line to display red dots whilst waiting for completion.
  # Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
  # See https://github.com/ohmyzsh/ohmyzsh/issues/5765
  COMPLETION_WAITING_DOTS="true"

  # Uncomment the following line if you want to disable marking untracked files
  # under VCS as dirty. This makes repository status check for large repositories
  # much, much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"

  # Uncomment the following line if you want to change the command execution time
  # stamp shown in the history command output.
  # You can set one of the optional three formats:
  # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
  # or set a custom format using the strftime function format specifications,
  # see 'man strftime' for details.
  # HIST_STAMPS="mm/dd/yyyy"

  # Would you like to use another custom folder than $ZSH/custom?
  # ZSH_CUSTOM=/path/to/new-custom-folder

  # Which plugins would you like to load?
  # Standard plugins can be found in $ZSH/plugins/
  # Custom plugins may be added to $ZSH_CUSTOM/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.
  plugins=(git zsh-autosuggestions z)

  source $ZSH/oh-my-zsh.sh

  # User configuration

  # export MANPATH="/usr/local/man:$MANPATH"

  # You may need to manually set your language environment
  # export LANG=en_US.UTF-8

  # Preferred editor for local and remote sessions
  # if [[ -n $SSH_CONNECTION ]]; then
  #   export EDITOR='vim'
  # else
  #   export EDITOR='mvim'
  # fi

  # Compilation flags
  # export ARCHFLAGS="-arch x86_64"
fi

# ------------------------------- pretty prompt ------------------------------

PROMPT='%F{068}%n%f in %F{141}%~%f -> '

# ---------------------------------- aliases ---------------------------------

source "$HOME"/aliases.zsh

# ---------------------------- check apple silicon ---------------------------
export APPLE_SILICON=false

if [[ $(sysctl -n machdep.cpu.brand_string) =~ "Apple" ]]; then
  APPLE_SILICON=true
fi

# --------------------------- environment variables --------------------------

export SCRIPTS="$HOME/.local/bin/scripts"
export SNIPPETS="$HOME/.local/snippets"
export MYVIMRC="$HOME/.vimrc"

export TERM=xterm-256color
export HRULEWIDTH=80
export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi

export GOPATH=~/.local/share/go
export GOBIN=~/.local/bin

 # ---------------------------------- my path ---------------------------------

path+=($HOME/.local/bin)
path+=($SCRIPTS)
path+=($SNIPPETS)

# homebrew's apple silicon stupid setup
if [[ "$APPLE_SILICON" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# wow, really hate that I have to do this, thanks smlnj
# also for future reference, the binary name is sml
path+=$(brew --prefix)/smlnj/bin
export PATH

# ------------------------------ sourced scripts -----------------------------
. $HOME/.local/bin/scripts/ocd
. $HOME/.local/bin/scripts/cdtmp

# ---------------------------- colors in manpages ----------------------------
# this is how we get colored man pages oooooh so fancy
# no one honestly knows what most of this does but it does make it pretty
# these variables are designed so that man will work with them

if test -x /usr/bin/lesspipe; then
  export LESSOPEN="| /usr/bin/lesspipe %s";
  export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi

export LESS_TERMCAP_mb="[35m"   # magenta
export LESS_TERMCAP_md="[33m"  # yellow
export LESS_TERMCAP_me=""
export LESS_TERMCAP_se=""
export LESS_TERMCAP_so="[34m"  # blue
export LESS_TERMCAP_ue=""
export LESS_TERMCAP_us="[4m"   # underline

# ---------------------------------- thefuck ---------------------------------
eval $(thefuck --alias)

# ------------------------------------ nvm -----------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ------------------------------------- z ------------------------------------
. "$HOME/src/git/z/z.sh"

# ------------------------------- python stuff -------------------------------

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pipenv
# export PIPENV_VENV_IN_PROJECT=1

alias pipenv-list='for venv in ~/.local/share/virtualenvs/* ; do basename $venv; cat $venv/.project | sed "s/\(.*\)/\t\1\n/" ; done'

# -------------------------- make life worth living --------------------------

set -o vi
fortune | ponysay

# -------------------------------- pomo-timer --------------------------------

# Requires https://github.com/caarlos0/timer to be installed
# Requires https://github.com/julienXX/terminal-notifier to be installed

alias work="timer 30m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

alias rest="timer 5m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"
