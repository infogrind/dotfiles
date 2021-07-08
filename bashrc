# This file should be symlinked as ~/.bashrc. Its contents are executed whenever
# a new shell is launched (both login and non-login shells, by explicitly
# calling it from .profile). See also the documentation at the top of profile.
#
# This file should contain any definitions that live only for the current shell
# and are not inherited by subshells. These most particularly include alias
# and function definitions.

# Function definitions

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
alias brewup='brew update && brew upgrade && brew cleanup -s && echo "All OK"'
alias gpp='git push && git push diskstation'

# Taken from https://stackoverflow.com/a/1571525
alias git-root='cd $(git rev-parse --show-toplevel)'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
