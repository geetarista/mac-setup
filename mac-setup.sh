#!/bin/bash

# Remove system Ruby
sudo rm -r /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8
sudo gem update --system
sudo gem clean

# RVM
bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
rvm install 1.8.6
rvm install 1.8.7
rvm install 1.9.2
rvm install macruby
rvm install rbx
rvm install jruby
rvm install ree
rvm --default ruby-1.9.2
rvm default

# pow
curl get.pow.cx | sh

ruby -e "$(curl -fsS http://gist.github.com/raw/323731/install_homebrew.rb)"

# Install packages
brew install ack
# brew install asterisk
brew install bcrypt
brew install bzip2
brew install couchdb
brew install ctags
brew install curl
brew install erlang
# brew install ffmpeg
# brew install git
# brew install graphviz
brew install growlnotify
brew install httperf
# brew install imagemagick
brew install lorem
# brew install macvim
brew install markdown
# brew install memcached
# brew install monit
brew install mysql
# brew install nginx --with-passenger
brew install node
# brew install pngcrush
brew install postgresql
brew install python
brew install rebar
# brew install readline
brew install rsync
# brew install sphinx
brew install sqlite
# brew install varnish
brew install wget
# brew install wkhtmltopdf

# Install npm
curl http://npmjs.org/install.sh | sh

# Node packages
npm -g install coffee-script
npm -g install express
npm -g install hamljs
npm -g install jade
npm -g install jake
npm -g install mongodb
npm -g install mongoose
npm -g install sass

# ZSH
# wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# Set theme to kennethreitz in ~/.zshrc

# Meslo font
wget https://github.com/downloads/andreberg/Meslo-Font/Meslo%20LG%20DZ%20v1.0.zip
unzip Meslo\ LG\ DZ\ v1.0.zip
cd Meslo\ LG\ DZ\ v1.0
for file in *.ttf; do
  mv $file ~/Library/Fonts/$file;
done

mkdir ~/workspace

# Dotfiles
cd ~/workplace
git clone git@github.com:geetarista/dotfiles.git
cd dotfiles
sh install.sh

# Vimfiles
cd ~/workplace
git clone git@github.com:geetarista/vimfiles.git
cd vimfiles
sh install.sh

# sudo env ARCHFLAGS="-arch x86_64" gem install mysql2 --no-rdoc --no-ri -- --with-mysql-config `which mysql_config`

# Start passenger standalone for all applications
cd ~/workspace && sudo passenger start -p 80 -u (some_unprivileged_username)

# MySQL local config
cat << MYCNF > /usr/local/var/mysql/my.cnf
[mysqld]
  collation_server=utf8_general_ci
  character_set_server=utf8
  default-character-set = utf8

[mysql]
  default-character-set = utf8

[client]
  default-character-set=utf8
MYCNF

# nginx config
# NGINX_PATH=`brew --prefix nginx`

# ssh key
ssh-keygen -t rsa

echo "Enter Github token to add ssh key: "
read github_token
echo "Enter title for ssh key: "
read github_title
export github_key=`cat ~/.ssh/id_rsa.pub`
curl -d "login=geetarista&token=${github_token}&title=`scutil --get ComputerName`&key=${github_key}" http://github.com/api/v2/yaml/user/key/add
