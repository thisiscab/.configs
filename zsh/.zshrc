# Script to benchmark speed:
# for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done

# export GPG_TTY=$(tty)
export DIRSTACKSIZE=9
export HISTSIZE=10000               # number of lines kept in history
export SAVEHIST=10000               # number of lines saved in the history after logout
export HISTFILE=~/.zsh_history     # location of history

export PATH=$HOME/bin:$PATH
export PATH=$HOME/.bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

export EDITOR=nvim
export LANG="C"

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS="--require-sha --no-quarantine"

# try to Fuzzy-match
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle ':completion::cd:' ignore-parents parent pwd # cd will never select the parent directory (e.g.: cd ../<TAB>)

zstyle ':completion:*' menu select=2 # Highly selection in menu if nb items > 2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Ignore case
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'   # Display the type of menu selection
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' # Convenient error message if can do nothing

# setopt inc_append_history          # append command to history file once executed
setopt histignoredups
setopt histreduceblanks
setopt promptsubst                 # enable colors to be displayed
setopt share_history # share hist between sessions

# setopt autocd               # automatically cd to a directory if not cmd
setopt braceccl             # {a-d} expands to a b c d
setopt always_to_end        # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word     # allow completion from within a word/phrase
setopt autopushd            # automatically pushd directories on dirstack
setopt nopushdsilent        # print dirstack after each cd/pushd
setopt pushdminus           # pushd -N goes to Nth dir in stack
setopt pushdignoredups      # don't push dups on stack
setopt cdablevars           # blah=~/media/movies; cd blah; pwd => ~/media/movies
setopt correct              # try to correct spelling...
setopt no_correctall        # ...only for commands, not filenames
setopt listpacked           # variable col widths (takes up less space)
# setopt auto_resume
# setopt auto_cd

export HOMEBREW_NO_ANALYTICS=1
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

autoload -Uz colors && colors
autoload -Uz compinit && (compinit &)

source $HOME/.zsh-theme
source $HOME/.aliases
source $HOME/.functions

source /usr/local/opt/asdf/libexec/asdf.sh

# tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]]; then
  tmuxinator default
fi

if [[ -f "$HOME/src/.configs_personal/zsh/.aliases_personal" ]]; then
  source $HOME/.aliases_personal
fi

if [[ -f "$HOME/src/.configs_personal/zsh/.functions_personal" ]]; then
  source $HOME/.functions_personal
fi

if [[ -f "$HOME/src/.configs_work/zsh/.aliases_work" ]]; then
  source $HOME/.aliases_work
fi

if [[ -f "$HOME/src/.configs_work/zsh/.functions_work" ]]; then
  source $HOME/.functions_work
fi

eval "$(direnv hook zsh)"

function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  bindkey -s '^p' "tmux-sessionizer\n"
}
export PATH="/usr/local/opt/openjdk/bin:$PATH"
