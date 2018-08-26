# Function definition

function ts   # ts x y sets screen width to x chars and y lines
{
  if [[ -n "$1" && -n "$2" && $1 > 0 && $2 > 0 ]]; then
    echo -ne "\033[8;$2;$1t"
  fi
}

# Alias definitions
alias ls='gls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
alias less='less -R'
alias more='more -R'
alias sst='svn st'
alias sup='svn up'
alias sci='svn ci'
alias gst='git status'
alias gci='git commit'

# Taken from https://stackoverflow.com/a/1571525
alias git-root='cd $(git rev-parse --show-toplevel)'

PATH="/Users/marius/.conscript/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
