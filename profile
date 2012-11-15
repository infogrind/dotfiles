export EDITOR="/usr/bin/vim"
export LANG=en_US.UTF-8

if [ -n "$PSOUT" ]; then
  export DISPLAY=":0.0"
fi

# Ruby environment variables
PREFIX=/usr/local
export GEM_HOME=$PREFIX/lib/ruby/gems/1.8
export RUBYLIB=$PREFIX/lib/ruby:$PREFIX/lib/site_ruby/1.8
export RUBYLIB=$RUBYLIB:$HOME/Library/Ruby/Site
export RUBYOPT='-rubygems'

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

# source all homebrew bash completion files
BREW_BASH_COMP_D="`brew --prefix`/etc/bash_completion.d"
if [ -d "$BREW_BASH_COMP_D" ]; then
    for f in "$BREW_BASH_COMP_D"/*; do
        [ -f "$f" ] && source "$f"
    done
fi

# Functions for git prompt
function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}

git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local cln=`git status | grep 'working directory clean'`
        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=${RED}
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
            local COLOR=${YELLOW}
        else
            local COLOR=${GREEN}
        fi
        local SINCE_LAST_COMMIT="\[${COLOR}\]$(minutes_since_last_commit)m\[${NC}\]"
        # The __git_ps1 function inserts the current git branch where %s is
        if [ -n "$cln" ]; then
            local GIT_PROMPT=`__git_ps1 "(%s)"`
        else
            local GIT_PROMPT=`__git_ps1 "(%s|${SINCE_LAST_COMMIT})"`
        fi
        echo ${GIT_PROMPT}
    fi
}

# Make a nice colorful prompt
export PROMPT_COMMAND='PS1="\[${LIGHTGREEN}\]\u@\h\[${LIGHTBLUE}\] \w \[${NC}\]$(git_prompt)\$ "'
#export PS1="\[${LIGHTGREEN}\]\u@\h\[${LIGHTBLUE}\] \w \[${NC}\]"'$(git_prompt)'"\$ " 

# Setting PATH for Python 2.7
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# More memory for sbt
export SBT_OPTS="-XX:MaxPermSize=256M"
