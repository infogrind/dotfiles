# Disable standard greeting message
set fish_greeting ""

# Always use UTF-8 for everything
set -x LC_ALL "en_US.UTF-8"

# My beloved default editor
set -x EDITOR /usr/local/bin/vim

# Include user's personal bin directory in the path
test -d $HOME/bin && fish_add_path -p -P $HOME/bin

# Make less behave properly with ansi codes
alias less='less -R'

# Environment variables required by GDK
set -x PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=/usr/local/opt/openssl@1.1 --with-readline-dir=/usr/local/opt/readline"
source /Users/marius/.asdf/asdf.fish
