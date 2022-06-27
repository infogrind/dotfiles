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

# Add personal bin directory to beginning of path.
export PATH=$HOME/bin:$PATH

# Run local .profile if it exists
if [ -f "$HOME/.profile_local" ]; then
	. "$HOME/.profile_local"
fi

# Run .bashrc if it exists
if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi
