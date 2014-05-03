dotfiles
========

Initial configuration for a new unix box

1. cd ~
2. git clone https://github.com/toddvelie/dotfiles
3. cd dotfiles
4. chmod u+x update.sh
5. ./update.sh

This will automatically pull down a customized prompt and vim config.

If any changes are mode:
  git add <modified file>
  git commit -m '<commit message>'
  git push orign master

To manually pull changes
  cd dotfiles
  git pull orign master
  git submodule init
  git submodule update

