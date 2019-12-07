# vim:ft=sh
export EDITOR="/usr/bin/vim"
export LANG=en_US.UTF-8

# Disable OS X Catalina warning about zsh being the default shell
# See https://apple.stackexchange.com/a/371998
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -n "$PSOUT" ]; then
  export DISPLAY=":0.0"
fi

# Ruby environment variables
PREFIX=/usr/local
export GEM_HOME=$PREFIX/lib/ruby/gems/1.8
export RUBYLIB=$PREFIX/lib/ruby:$PREFIX/lib/site_ruby/1.8
export RUBYLIB=$RUBYLIB:$HOME/Library/Ruby/Site
export RUBYOPT='-rubygems'

# Java
# See http://stackoverflow.com/a/6588410
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# Run .bashrc if it exists
if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi

# Import color definitions if they exist
if [ -f $HOME/.ansi_colors ]; then
    . $HOME/.ansi_colors
fi

# Move /usr/local/bin to beginning of path
CLEANPATH=`echo $PATH | sed -E 's#/usr/local/bin:?##'`
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Add personal bin directory to beginning of path.
export PATH=$HOME/bin:$PATH

## source all homebrew bash completion files
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
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

# Setting PATH for Python 2.7
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# More memory for sbt
export SBT_OPTS="-XX:MaxPermSize=256M"

# Fix OS X locale (otherwise python locale won't work well)
# See http://fruitfulerrors.blogspot.hu/2011/01/osx-106-lcctype.html
export LC_CTYPE="en_US.utf-8"
