#	  __ _     _     
#	 / _(_)___| |__  
#	| |_| / __| '_ \ 
#	|  _| \__ \ | | |							https://github.com/JefVP
#	|_| |_|___/_| |_|							my fish config, nothing special.
                 

# INITIALISE
set fish_greeting ""							# Supress "Welcome to fish..." message
set TERM "st-256color"							# Set terminal to ST
set EDITOR "nvim"								# Set editor to Neovim

# VI MODE KEYBINDS
function fish_user_key_bindings
	fish_vi_key_bindings
end

# ALIASES
# Quick open config
alias bconf='nvim ~/.bashrc'					# edit bash config
alias fconf='nvim ~/.config/fish/config.fish'	# Edit fish config
alias pconf='nvim ~/.config/polybar/config.ini'	# Edit polybar config
alias xconf='nvim ~/.xmonad/xmonad.hs'			# Edit xmonad config

# Terminal stuff
alias vim='nvim'								# Open Neovim instead of vim
alias cls='clear'								# Shorter clear
alias grep='grep --color=auto'					# More colour in the grep output

# Power
alias sdn='sudo shutdown now'					# Turn off computer
alias sdr='sudo reboot now'						# Restart computer

# File management aliases
alias ls='exa -alh'								# Set ls to a more colourful and lengthy output
alias tree='exa -ahT'							# Get a colourful filesystem tree for whatever directory
alias df='df -h'								# Show df output in a human readable format by default
alias du='du -h'								# Show du output in a human readable format by default

# Internet stuff
alias myip='curl ipinfo.io/ip'					# Get your public IP
alias weather='curl wttr.in'					# Get weather informatoin based on your IP address

# Misc stuff
alias nf='neofetch'

# Fish Prompt
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end
