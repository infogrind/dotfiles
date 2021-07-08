# This file should be symlinked as ~/.profile (or perhaps ~/.bash_profile).
# It is executed each time a login shell is opened, but not when a non-login
# shell is opened (see https://apple.stackexchange.com/a/51038 for details and
# https://unix.stackexchange.com/a/46856 for the difference between different
# shell invocations.
#
# Note that default behavior in Mac OS is to launch a login shell for each new
# terminal window or tab (but this can be changed in Terminal.app's settings).
#
# Since the contents of this file are only executed for login shells, any
# commands or definitions whose scope is the current shell only, most
# particularly alias or function definitions, should not go here but to .bashrc
# instead. On the other hand, variable exports are fine here, as these will be
# inherited by subshells.

# vim:ft=sh
export EDITOR="/usr/bin/vim"

# Locale settings to enable proper use of Unicode/UTF-8 throughout
export LC_ALL=en_US.UTF-8

# Disable OS X Catalina warning about zsh being the default shell
# See https://apple.stackexchange.com/a/371998
export BASH_SILENCE_DEPRECATION_WARNING=1

# Run .bashrc if it exists
if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi

# Import color definitions if they exist
if [ -f $HOME/.ansi_colors ]; then
    . $HOME/.ansi_colors
fi

# Add (or move) Homebrew prefix to the beginning of the PATH
CLEANPATH=`echo $PATH | sed -E 's#/usr/local/bin:?##'`
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Add personal bin directory to beginning of path.
export PATH=$HOME/bin:$PATH

## source all homebrew bash completion files
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

export PROMPT_COMMAND='PS1="\[${LIGHTGREEN}\]\u@\h\[${LIGHTBLUE}\] \W\[${NC}\]$(git_prompt) \$ "'

# Path config for Rust installation
export PATH="$HOME/.cargo/bin:$PATH"

# Added by GDK bootstrap
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:${PKG_CONFIG_PATH}"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1 --with-readline-dir=/usr/local/opt/readline"
source /Users/marius/.asdf/asdf.sh
