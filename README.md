dotfiles
========

####Initial configuration for a new unix box:
1. cd ~
2. git clone https://github.com/toddvelie/dotfiles
3. cd dotfiles
4. chmod u+x update.sh
5. ./update.sh

####Easy update if changes are made:
1. cd ~/dotfiles
2. ./update.sh

####To save any changes to GitHub:
1. git add \<modified file\>
2. git commit -m '\<commit message\>'
3. git push --set-upstream origin master

####To manually pull changes:
1. cd dotfiles
2. git pull orign master
3. git submodule init
4. git submodule update

