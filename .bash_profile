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
alias restart='source ~/.bash_profile'
alias resource='source ~/.bash_profile && echo "Done!"'
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

