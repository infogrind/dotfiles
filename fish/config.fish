################################################################################
# Fish-specific configuration
################################################################################

# Disable standard greeting message
set fish_greeting ""


################################################################################
# Environment variables
################################################################################

# Always use UTF-8 for everything
set -x LC_ALL "en_US.UTF-8"

# My beloved default editor
set -x EDITOR /usr/local/bin/vim

# Include user's personal bin directory in the path
test -d $HOME/bin && fish_add_path -p -P $HOME/bin

# Environment variables required by GDK
set -x PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=/usr/local/opt/openssl@1.1 --with-readline-dir=/usr/local/opt/readline"
source /Users/marius/.asdf/asdf.fish


################################################################################
# Aliases and Functions
################################################################################

# Make less behave properly with ansi codes
alias less='less -R'

# One-command Homebrew update
alias brewup='brew update && brew upgrade && brew autoremove && brew cleanup -s && echo "All OK"'

# Push my private repo quickly to all remotes
alias gpp='git push && git push diskstation'

# Note that .bashrc currently contains other aliases, but in practice I have
# found that I am not really using these, so I am not migrating them for now.

set -gx FZF_DEFAULT_COMMAND "fd --type file --color=always"
set -gx FZF_DEFAULT_OPTS "--ansi"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
