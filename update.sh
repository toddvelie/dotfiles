#!/bin/bash
############################
# .update.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim dir_colors tmux.conf oh-my-zsh zshrc minttyrc ssh"    # list of files/folders to symlink in homedir
themes="bunsen.zsh-theme"
updatemethod="git"

########## Determine update method
echo "Determining update method"
if command -v git >/dev/null != ''; then
    updatemethod="git"
else
    updatemethod="scp"
fi
echo "Selected $updatemethod."

########## Refresh git and submodules
if [[ $updatemethod == "git" ]]; then
   echo "Refreshing from GitHub"
   git pull origin master
   git submodule init
   git submodule update
   echo "...done"
else
    echo "Pulling dotfiles directory"
    scp -r toddv@wn7-d-toddv:~/dotfiles ~/dotfiles
    echo "...done"
fi
#########

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
			if ! [[ -d $olddir ]]; then
				echo "Creating $olddir for backup of existing dotfiles in ~"
				mkdir -p $olddir
				echo "...done"
			fi
			echo "Moving existing dotfile .$file from ~ to $olddir"
			mv ~/.$file ~/dotfiles_old/
	    fi
		
		echo "Creating symlink to $file in home directory."
		ln -s $dir/$file ~/.$file
	fi
done
echo "...done"

# Link any omz-themes to the oh-my-zsh theme subdirectory
echo "Creating symlinks for oh-my-zsh themes"
for file in $themes; do
	# If it is a symbolic link, check it for validity
    if [[ -L $dir/oh-my-zsh/themes/$file ]]; then
		if ! [[ $(readlink $dir/oh-my-zsh/themes/$file)  = $dir/omz-themes/$file  ]]; then
			echo "Symlink is incorrect: $dir/oh-my-zsh/themes/$file, re-creating properly"
			rm $dir/oh-my-zsh/themes/$file
			ln -s $dir/omz-themes/$file $dir/oh-my-zsh/themes/$file
		else
			echo "Symlink already exists: $dir/omz-themes/$file, skipping."
		fi
	# It's not a symlink, so move it, and create the proper symlink
	else
		echo "Creating symlink to $file in oh-my-zsh theme directory"
		ln -s $dir/omz-themes/$file $dir/oh-my-zsh/themes/$file
	fi
done
echo "...done"
