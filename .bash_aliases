# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

alias aliases='log'
alias c='clear'
alias ggrep='git grep -iIn --fixed-strings --break --'
alias gitdel='git fetch --prune && git branch --merged master | egrep -v '\''^\s*\*?\s*master$'\'' | xargs git branch -d'
alias gitlog='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset'\'' --abbrev-commit --date=relative'
alias gp='gulp --production'
alias gw='gulp watch'
alias h='htop'
alias hardreset='git fetch origin && git reset --hard origin/master'
alias ls='ls -a --color=auto'
alias masterdiff='git diff --name-status master..HEAD'
alias bashreload='source ~/.bashrc'
alias undocommit='git reset HEAD~'
alias phpshell='psysh'

export CONTAINER_USER=$(id -u)':'$(id -g)