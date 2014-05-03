#!/bin/bash
############################
# .update.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim dir_colors"    # list of files/folders to symlink in homedir

########## Refresh git and submodules
echo "Refreshing from GitHub"
git pull origin master
git submodule init 
git submodule update
echo "...done"

#########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Creating symlinks"
for file in $files; do
	# If it is a symbolic link, check it for validity
    if [[ -L ~/.$file ]]; then
		if ! [[ $(readlink ~/.$file) = $dir/$file  ]]; then
			echo "Symlink is incorrect: ~/.$file, re-creating properly"
			rm ~/.$file
			ln -s $dir/$file ~/.$file
		else
			echo "Symlink already exists: ~/.$file, skipping."
		fi
	# It's not a symlink, so move it, and create the proper symlink
	else
		if [[ -f ~/.$file ]]; then
			echo "Moving existing dotfile .$file from ~ to $olddir"
			mv ~/.$file ~/dotfiles_old/
	    fi
		
		echo "Creating symlink to $file in home directory."
		ln -s $dir/$file ~/.$file
	fi
done
echo "...done"
