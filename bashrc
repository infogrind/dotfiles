# This file should be symlinked as ~/.bashrc. Its contents are executed whenever
# a new shell is launched (both login and non-login shells, by explicitly
# calling it from .profile). See also the documentation at the top of profile.
#
# This file should contain any definitions that live only for the current shell
# and are not inherited by subshells. These most particularly include alias
# and function definitions.

################################################################################
# Bash completions
################################################################################

# Source all homebrew bash completion files
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# fzf initialization includes bash completions, so we need to include it here
# rather than in profile:
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


################################################################################
# Function definitions
################################################################################

function ts   # ts x y sets screen width to x chars and y lines
{
  if [[ -n "$1" && -n "$2" && $1 > 0 && $2 > 0 ]]; then
    echo -ne "\033[8;$2;$1t"
  fi
}

# Functions for git prompt
function minutes_since_last_commit {
    now=`date +%s`
    last_commit="$(git log --pretty=format:'%at' -1 2>/dev/null)"
    if [ -n "$last_commit" ]; then
        seconds_since_last_commit=$((now-last_commit))
        minutes_since_last_commit=$((seconds_since_last_commit/60))
        echo $minutes_since_last_commit
    else
        echo 0
    fi
}

git_prompt() {
    local DATE=`date`
    local GITDIR=`__gitdir`
    if [ -n "$GITDIR" ]; then

        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`

        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=${RED}
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
            local COLOR=${YELLOW}
        else
            local COLOR=${GREEN}
        fi

        BRANCH=`__git_ps1 '%s'`
        MINUTES="\[${COLOR}\]${MINUTES_SINCE_LAST_COMMIT}m\[${NC}\]"
        GIT_PROMPT=" (${BRANCH}|${MINUTES})"
        echo "$GIT_PROMPT"
    fi
    #echo "\[${GREEN}\]Green: ${DATE} \[${RED}\]Hello world \[${NC}\]"
}

################################################################################
# Alias definitions
################################################################################

alias ls='gls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
alias less='less -R'
alias more='more -R'
alias sst='svn st'
alias sup='svn up'
alias sci='svn ci'
alias g='git'
alias gd='git diff'
alias gst='git status'
alias gci='git commit'
alias brewup='brew update && brew upgrade && brew cleanup -s \
	&& brew autoremove && echo "All OK"'
alias gpp='git push && git push diskstation'

# Taken from https://stackoverflow.com/a/1571525
alias git-root='cd $(git rev-parse --show-toplevel)'



################################################################################
# Other (sub)shell specific configuration
################################################################################

# Fancy git prompt (uses the above two functions)
# Import color definitions if they exist
if [ -f $HOME/.ansi_colors ]; then
    . $HOME/.ansi_colors
fi
PROMPT_COMMAND='PS1="\[${LIGHTGREEN}\]\u@\h\[${LIGHTBLUE}\] \W\[${NC}\]$(git_prompt) \$ "'
