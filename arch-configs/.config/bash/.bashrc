#	 ____    _    ____  _   _ 
#	| __ )  / \  / ___|| | | |
#	|  _ \ / _ \ \___ \| |_| |
#	| |_) / ___ \ ___) |  _  |							https://github.com/JefVP/
#	|____/_/   \_\____/|_| |_|							My bashrc, while I don't use bash, I will add all aliases from my zsh config.
                          
[[ $- != *i* ]] && return								# If not running interactively, don't do anything

# ----------------------------------------------
# VARIABLES
# ----------------------------------------------
export TERM="st-256color"								# Setting terminal to ST
export EDITOR="nvim"									# Setting my default editor to neovivm
export PS1="\[\033[38;5;14m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;14m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]: \[$(tput sgr0)\]"

# ----------------------------------------------
# ALIASES
# ----------------------------------------------
# editing configs
alias zconf='nvim ~/.zshrc'								# Edit zsh config
alias pconf='nvim ~/.config/polybar/config'				# Edit polybar config
alias xconf='nvim ~/.xmonad/xmonad.hs'					# Edit xmonad config

# Terminal related aliases
alias vim='nvim'										# Open neovim instead of vim
alias cls='clear'										# Shorter clear
alias grep='grep --color=auto'							# More colour in the grep output

# Power aliases
alias sdn='sudo shutdown now'							# Turn off computer
alias sdr='sudo reboot now'								# Restart computer

# File management aliases
alias ls='exa -alh'										# Set ls to a more colourful and lenghty output
alias tree='exa -ahT'									# Get a filesystem tree from whatever directory
alias df='df -h'										# Show df output in a human readable format
alias du='du -h'										# Show du output in a human readable format

# Internet related aliases
alias myip='curl ipinfo.io/ip'							# Get your public IP address
alias weather='curl wttr.in'							# Get weather information based on your IP address

# Misc aliases
alias nf='neofetch'										# Shorten neofetch command to nf
alias sx='startx'										# Start X server faster

