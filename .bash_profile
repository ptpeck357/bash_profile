# For git, also drop these into the command line to make sure
# pulling and pushing work properly:
# git config --global pull.default current
# git config --global user.name "dhg"
# git config --global user.email "dhgamache@gmail.com"


export PATH=/opt/local/bin:/opt/local/sbin:${PATH}
export PATH=~/.composer/vendor/bin:$PATH

## Tools

## Shortcuts
alias aliases='log'
alias c='clear'
alias editbash='subl ~/.bash_profile'
alias restart='source ~/.bash_profile && echo "Done!"'
alias refreshnodemodules='rm -rf node_modules/ && yarn install'

## Directories

## Git commands
alias branch='git branch'
alias diff='git diff'
alias fetch='git fetch'
alias gmm='git merge master'
alias ggrep='git grep -iIn --fixed-strings --break --'
alias gitdel='git fetch --prune && git branch --merged master | egrep -v '\''^\s*\*?\s*master$'\'' | xargs git branch -d'
alias gitlog='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset'\'' --abbrev-commit --date=relative'
alias log='git log'
alias masterdiff='git diff --name-status master..HEAD'
alias pull='git pull'
alias push='git push origin head'
alias st='git status'
alias undocommit='git reset HEAD~'
alias ..='cd ..'

# For git tab completion
source /etc/.git-prompt.sh
source /etc/bash_completion.d/git-prompt
source /etc/bash_completion.d/git-completion.bash
source /etc/bash_completion.d/fabric-completion.bash

## Git functions
checkoutFunction() {
  git checkout $1
}

gitfindtag() {
    git tag --contains $1 | sed -n 1p
}

function git-branch-name {
    echo $(git symbolic-ref HEAD 2>/dev/tty | awk -F/ {'print $NF'})
}

function parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function git-dirty {
    st=$(git status 2>/dev/tty | tail -n 1)
    if [[ $st != "nothing to commit (working directory clean)" ]]
    then
        echo "*"
    fi
}

function git-unpushed {
    brinfo=$(git branch -v | grep git-branch-name)
    if [[ $brinfo =~ ("[ahead "([[:digit:]]*)]) ]]
    then
        echo "(${BASH_REMATCH[2]})"
    fi
}

function gitify {
    status=$(git status 2>/dev/null | tail -n 1)
    if [[ $status == "" ]]
    then
        echo ""
    else
        echo $(parse_git_branch())$(git-dirty)$(git-unpushed)
    fi
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

## Allows git autocomplete (http://code-worrier.com/blog/autocomplete-git/)
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi












# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
esac
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
	else
	color_prompt=
	fi
fi
if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
fi

orange=$(tput setaf 166);
green=$(tput setaf 118);
white=$(tput setaf 250);
pink=$(tput setaf 205);
blue=$(tput setaf 123);
grey=$(tput setaf 240);
bold=$(tput bold);
export PS1; #\[ \]

#### Peter's stuff
# for showing the status of the git branch at the prompt
GIT_PS1_SHOWDIRTYSTATE=true
function proml {
local       HOST_NAME="dev.ccb"
local       BLUE="\[\033[0;34m\]"
local       RED="\[\033[0;31m\]"
local       LIGHT_RED="\[\033[1;31m\]"
local       GREEN="\[\033[0;32m\]"
local       LIGHT_GREEN="\[\033[1;32m\]"
local       WHITE="\[\033[0;37m\]"
local       LIGHT_BLUE="\[\033[38;5;45m\]"
local       ORANGE="\[\033[38;5;208m\]"
local       LIGHT_GRAY="\[\033[0;37m\]"
local       END_COLOR="\[\e[m\]"
local       TITLEBAR='\[\033]0;\u@\h:\w\007\]'
PS1+="$TITLEBAR\
$LIGHT_GRAY\h $RED::$LIGHT_GREEN \w$ORANGE\$(__git_ps1)» $LIGHT_GRAY"
PS2='> '
PS4='+ '
}
proml

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}