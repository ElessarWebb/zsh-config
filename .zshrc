autoload colors && colors

# history settings
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt inc_append_history
setopt share_history

# disable annoying stuff
unsetopt autocd beep nomatch notify

# leave expansion to _expand
bindkey '^I' complete-word

# vi mode shortcuts
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# vi mode with emacs behaviour
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M viins '^r' history-incremental-pattern-search-backward
bindkey '^[[Z' reverse-menu-complete

# vim-style behaviour
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^u' backward-kill-line
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo
bindkey -M vicmd '^R' redo

# awesome keybindings
bindkey -M vicmd -s 'T' '^[ Isudo ^[A'

# editing cmd in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# display the correct time and battery data
# every time the prompt is drawn
# and set the left prompt
function precmd {
	local BAT

	# set the LPROMPT
	prompt="
%{$fg[white]%} { "
	if [[ "$EUID" = "0" ]] || [[ "$USER" = 'root' ]]
	then
		prompt="${prompt}%{$fg[red]%}"
	else
		prompt="${prompt}%{$fg[blue]%}"
	fi
	prompt="${prompt}%m%{$fg[white]%}: %~ }%{$reset_color%} "

	# set the RPROMPT
	BAT=`acpi -b \
		| sed "s/[^:]*:\s*\([^,]*\)\,\s*\([0-9]\+\).*/%{$fg[green]%}\1%{$fg[white]%} \2%%/" \
		| tr "\n" " "`

	export RPROMPT="%{$fg[white]%}$( date +"%a %d %H:%M" ) :: $BAT% %{$reset_color%}"
	export PROMPT="$prompt"
}

# aliasses
alias ls='ls --color=auto'
alias lc='ls -lh --color=auto --group-directories-first'
alias gt='urxvt &'
alias django='python manage.py'
alias mk='mkdir'

# handy global aliasses
alias -g '...'='../../'
alias -g '....'='../../../'

# git aliasses
alias gits='git status'
alias gitd='git diff'
alias gitc='git checkout'
alias gitdc='git diff --cached'
alias gitca='git commit --amend'
alias gitap='git add -p'
function gitpl {
	git pull origin `git branch | grep \* | sed 's/\* //'`
}
function gitplr {
	git pull -r origin `git branch | grep \* | sed 's/\* //'`
}
function gitps {
	git push origin `git branch | grep \* | sed 's/\* //'`
}

# open vim using a server name for future reference
function v {
	# usage: vim <servername=ROOT>
	if [ -z $2 ]
	then
		# oke this looks convoluted, let's explain:
		# we ask i3 for the desktop number and let this be the server name per default
		# such that per default, we open a file on the same space as the terminal we open it from
		2=`i3-msg --type get_workspaces | python -c \
			"import sys; import json; print( list( filter( lambda w:\
			w[ 'focused' ], json.loads( sys.stdin.read() )))[0][ 'num' ])"`
	fi

	urxvt -e vim --servername $2 --remote-tab-silent $1 &> /dev/null &
}

# open a remote tab in gvim
alias gvimrt='gvimr'
function gvimr {
	gvim --remote-tab $1
}

# up, up, up the stairs...
function up {
	for a in {1..$1}
	do
		cd ../
	done
}

# Automatically change the directory in bash after closing ranger
function ranger-cd {
    tempfile='/tmp/chosendir'
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# This binds Ctrl-O to ranger-cd:
bindkey -s '^O' "ranger-cd\n"

# completion plugins
fpath=(~/.zsh/completion $fpath)

# zshell globbing magic
setopt extendedglob

# do not select the first menu entry automatically
unsetopt menu_complete
autoload -U compinit
compinit

# use cache to make slow stuff like pip and pacman work nicely
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# list colors
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

# Completion Styles
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
