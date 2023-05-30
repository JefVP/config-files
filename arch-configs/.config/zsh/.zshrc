#	         _     
#	 _______| |__  
#	|_  / __| '_ \ 
#	 / /\__ \ | | |								https://github.com/JefVP
#	/___|___/_| |_|								my zsh config, nothing special

# ----------------------------------------------
# INITIALISE
# ----------------------------------------------
TERM='st-256color'								# Set terminal emulator to ST
EDITOR='nvim'									# Set default editor to neovim

#autoload -U colors && colors					# enable colours
HISTFILE=~/.config/zsh/zsh_history				# Setting history file
HISTSIZE=1000									# History file 1000 lines
SAVEHIST=1000									# History file 1000 lines

setopt autocd nomatch histignorespace nocaseglob # Typing dir name will cd into it
unsetopt beep extendedglob notify				# No Beeps

#PROMPT="%F{81}%n%f%F{15}@%f%F{87}%m ❯ %f%F{15}"
#RPROMPT="%~"
PROMPT="%F{81}%n%f%F{15}@%f%F{87}%m:%f%F{81}[%~]%f%F{15}: "

zstyle ':completion:*' menu select
autoload -Uz compinit
compinit
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

    echo -ne '\e[5 q'							# Use beam shape cursor on startup.

    preexec() {
       echo -ne '\e[5 q'						# Use beam shape cursor for each new prompt.
    }



# ----------------------------------------------
# ALIASES
# ----------------------------------------------
# editing configs
alias zconf='nvim ~/.zshrc'						# Edit zsh config
alias pconf='nvim ~/.config/polybar/config'		# Edit polybar config
alias xconf='nvim ~/.xmonad/xmonad.hs'			# Edit xmonad config

# Terminal related aliases
alias vim='nvim'								# Open neovim instead of vim
alias cls='clear'								# Shorter clear
alias grep='grep --color=auto'					# More colour in the grep output

# Power aliases
alias sdn='sudo shutdown now'					# Turn off computer
alias sdr='sudo reboot now'						# Restart computer

# File management aliases
alias ls='exa -alh'								# Set ls to a more colourful and lenghty output
alias tree='exa -ahT'							# Get a colourful filesystem tree from whatever directory
alias df='df -h'								# Show df output in a human readable format by default
alias du='du -h'								# Show du output in a human readable format by default

# Internet related aliases
alias myip='curl ipinfo.io/ip'					# Get your public IP address
alias weather='curl wttr.in'					# Get weather information based on your IP address

# Misc aliases
alias nf='neofetch'								# Shorten neofetch command to nf
alias sx='startx'								# Start X server faster

# Github related.
# alias grabcf=''

# ----------------------------------------------
# Plugins
# ----------------------------------------------

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ffffff,bg=cyan,bold,underline"
