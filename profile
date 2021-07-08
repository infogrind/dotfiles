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

# Add (or move) Homebrew prefix to the beginning of the PATH
CLEANPATH=`echo $PATH | sed -E 's#/usr/local/bin:?##'`
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Add personal bin directory to beginning of path.
export PATH=$HOME/bin:$PATH

# Path config for Rust installation
export PATH="$HOME/.cargo/bin:$PATH"

# Added by GDK bootstrap
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:${PKG_CONFIG_PATH}"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1 --with-readline-dir=/usr/local/opt/readline"
source /Users/marius/.asdf/asdf.sh
