#	         _     
#	 _______| |__  
#	|_  / __| '_ \ 
#	 / /\__ \ | | | https://github.com/JefVP
#	/___|___/_| |_| my zsh config, nothing special

# ----------------------------------------------
# INITIALISE
# ----------------------------------------------

HISTFILE=~/.config/zsh/zsh_history # Setting history file
HISTSIZE=1000 # History file 1000 lines
SAVEHIST=1000 # History file 1000 lines

setopt autocd nomatch histignorespace nocaseglob appendhistory # Enabling some desirable options.
unsetopt beep extendedglob notify # Disabling some undesirable options

zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

# ----------------------------------------------
# EXPORTS
# ----------------------------------------------
PROMPT="%F{81}%n%f%F{15}@%f%F{87}%m:%f%F{81}[%~]%f%F{15}: " # Set Arch themed prompt
TERM='alacritty' # Set terminal emulator to Alacritty, set this one for whatever terminal you use.
EDITOR='nvim' # Set default editor to neovim
BROWSER='firefox' # Set browser to firefox

XDG_CONFIG_HOME='/home/jef/.config'
XDG_CACHE_HOME='/home/jef/.cache'
XDG_DATA_HOME='/home/jef/.local/share'
WGETRC="$XDG_CONFIG_HOME/wgetrc"
CARGO_HOME="$XDG_DATA_HOME"/cargo

# ----------------------------------------------
# VI MODE
# ----------------------------------------------
bindkey -v										# Vim keybinds

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
    zle -N zle-keymap-select

    echo -ne '\e[5 q' # Use beam shape cursor on startup.

    preexec() {
       echo -ne '\e[5 q' # Use beam shape cursor for each new prompt.
    }

# ----------------------------------------------
# ALIASES
# ----------------------------------------------
# editing configs
alias zconf='nvim ~/.zshrc' # Edit zsh config
alias xconf='nvim ~/.config/xmonad/xmonad.hs' # Edit xmonad config

# Terminal related aliases
alias vim='nvim' # Open neovim instead of vim
alias grep='grep --color=auto' # More colour in the grep output

# Power aliases
alias sdn='sudo shutdown now' # Turn off computer
alias sdr='sudo reboot now' # Restart computer

# File management aliases
alias ls='exa -alh' # Set ls to a more colourful and lenghty output
alias tree='exa -ahT' # Get a colourful filesystem tree from whatever directory
alias df='df -h' # Show df output in a human readable format by default
alias du='du -h' # Show du output in a human readable format by default
alias untar='tar xvpf' # quicker way to extract tarballs

# Internet related aliases
alias myip='curl ipinfo.io/ip' # Get your public IP address
alias weather='curl wttr.in' # Get weather information based on your IP address
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# Misc aliases
alias sx='startx' # Start X server faster
alias ytdl='/home/jef/.config/scripts/ytdl.sh' # calls my youtube dl handling script

# ----------------------------------------------
# SSH RELATED ALIASES
# ----------------------------------------------
alias serv='ssh jef@139.162.142.88' # Quick way to ssh into my Server
alias gent='ssh jef@192.168.122.227' # Quick way to ssh into my Gentoo vm
# ----------------------------------------------
# Plugins
# ----------------------------------------------
# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
