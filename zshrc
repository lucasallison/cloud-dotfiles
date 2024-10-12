# ZSHRC

# Open default nix-shell 
if [[ ! -n "$IN_NIX_SHELL" ]]; then
	echo "Opening default Nix shell..."
	. ~/.config/.open_default_nix_shell.sh
fi

# Default editor 
VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR

# Git info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%b"

precmd() { vcs_info }

# Check if we are in a Nix shell
if [[ -n "$IN_NIX_SHELL" ]]; then
    NIX_SHELL_INDICATOR="%F{33}(nix)%f "  # Yellow text to indicate Nix shell
else
    NIX_SHELL_INDICATOR=""
fi

# Prompt
setopt prompt_subst
BRANCH='${vcs_info_msg_0_}'
PATH_TO_SHOW="%c"
RPROMPT="%B${BRANCH} [%F{111}${PATH_TO_SHOW}%f]%b"

function zle-line-init zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/!}/(main|viins)/ }"
    PROMPT="%B${NIX_SHELL_INDICATOR}[%F{76}%n%f]%F{196}${VIMODE}%f$%b "
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

function prompt-after-exe {
    OLD_PROMPT="@PROMPT"
    PROMPT="%B${NIX_SHELL_INDICATOR}[%F{76}%n%f] $%b "
    zle reset-prompt
    PROMPT="@OLD_PROMPT"
    zle accept-line
}
zle -N prompt-after-exe

# Toggle full path/current directory
function path() {
    if [[ "$PATH_TO_SHOW" == "%c" ]]; then 
        RPROMPT="%B${BRANCH} [%F{111}%~%f]%b"
        PATH_TO_SHOW="%~"
    else 
        RPROMPT="%B${BRANCH} [%F{111}%c%f]%b"
        PATH_TO_SHOW="%c"
    fi
}

# Bind the enter key to the function
bindkey -M viins "^M" prompt-after-exe
bindkey -a "^M" prompt-after-exe

# vi mode 
bindkey -v 
export KEYTIMEOUT=10 
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey -M viins 'lj' vi-cmd-mode

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Keybindings
bindkey '^R' history-incremental-search-backward
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Aliases
alias c='clear'
alias ls='ls --color'
alias ll='ls -lah --color'
alias python='python3'
alias penv='source .venv/bin/activate; which python3'
alias venv='virtualenv .venv; penv'

alias zshrc='vim ~/.zshrc; source ~/.zshrc'

# TODO refactor this...
function ff() {

	local cmd=''
	local cmd_flags=''
	local fd_flags=''
	local fd_dir='$HOME '
	# Go to dirctory directory
	if [[ "$1" == "d" || "$1" == "g"|| "$1" == "dir" ]]; 
	then 
		cmd+='cd '
		fd_flags='-t d '
	# Open file in vim
	elif [[ "$1" == "v" || "$1" == "vim" ]];
	then
		cmd+='vim '
	# Open file with the open command
	elif [[ "$1" == "o" || "$1" == "open" ]];
	then
		cmd+='open '
	elif [[ "$1" == "cp" ]];
	then 
		cmd+='cp -r '
		cmd_flags+='./'
	elif [[ "$1" == "mv" ]];
	then
		cmd+='mv '
		cmd_flags+='./'
	fi

	if [[ "$2" == "l" || "$2" == "local" ]];
	then 
		fd_dir=' '
	fi

	if [[ "$3" == "h" || "$2" == "hidden" ]];
	then 
		fd_flags+='-H '
	fi

	cmd+='"$(fd . '
	cmd+=${fd_flags}
	cmd+=${fd_dir}
	cmd+='| fzf)" '
	cmd+=${cmd_flags}

	echo ${cmd}
	eval ${cmd}
}

export LS_COLORS='di=36:ln=1;31:so=37:pi=1;33:ex=35:bd=37:cd=37:su=37:sg=37:tw=32:ow=32'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Autojump
. ~/.config/.source_autojump.sh
autoload -U compinit && compinit -u

# Syntax highlighting
. ~/.config/.source_zsh_syntax_highlighting.sh
