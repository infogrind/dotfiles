#!/bin/bash
################################################################################
# install.sh
# This script creates symlinks from the home directory
# to any desired dotfiles in ~/.dotfiles
################################################################################

# Variables
dir=~/.dotfiles
backup_dir=~/.dotfiles_bak
files="bashrc gitconfig hgrc profile sitecopyrc"
manual_files=subversion_config

# Change to the dotfiles directory
echo "Changing to $dir"
cd $dir

for file in $files; do
    if [ -L ~/.$file ]; then
        echo "Symlink ~/.$file already exists, skipping"
        continue
    elif [ -e ~/.$file ]; then
        echo "Moving ~/.$file to backup dir $backup_dir"
        [ -d "$backup_dir" ] || mkdir "$backup_dir"
        mv -v ~/.$file "$backup_dir"
    fi
    echo "Creating symlink ~/.$file"
    ln -s $dir/"$file" ~/.$file
done
