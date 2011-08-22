#!/bin/bash

## General settings
# Also see: http://www.mactricksandtips.com/2008/02/top-50-terminal-commands.html

# Finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder DesktopViewOptions -dict IconSize -integer 72
defaults write com.apple.finder AppleShowAllFiles true

# Safari
defaults write com.apple.Safari IncludeDebugMenu 1
defaults write com.apple.Safari WebKitDeveloperExtras -bool true

# iTunes
defaults write com.apple.iTunes allow-half-stars -bool true
defaults write com.apple.iTunes invertStoreLinks -bool true

# Dock
defaults write com.apple.Dock autohide -bool true
defaults write com.apple.dock largesize -int 65
defaults write com.apple.dock tilesize -int 45

# Spotlight
sudo chmod 0 /System/Library/CoreServices/Spotlight.app

# Mouse
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode "TwoButton"

# Printing
defaults write -g PMPrintingExpandedStateForPrint -bool true

killall Finder
killall Dock
killall Spotlight

# Do not hide ~/Library in Lion
chflags nohidden /Users/robbycolvin/Library

# Remove system Ruby
sudo rm -r /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8
sudo gem update --system
sudo gem clean

# RVM
bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
rvm package install readline
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
brew install macvim --override-system-vim
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

# Link all applications
mkdir ~/Applications
brew linkapps

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

mkdir ~/src

cd ~/src

# Meslo font
wget https://github.com/downloads/andreberg/Meslo-Font/Meslo%20LG%20DZ%20v1.0.zip
unzip Meslo\ LG\ DZ\ v1.0.zip
cd Meslo\ LG\ DZ\ v1.0
for file in *.ttf; do
  mv $file ~/Library/Fonts/$file;
done
cd ..

# Install Hex Color Picker
http://wafflesoftware.net/hexpicker/download/1.6.1/
unzip HexColorPicker-1.6.1.zip
mv Hex\ Color\ Picker/HexColorPicker.colorPicker ~/Library/ColorPickers

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

# dotjs
cd ~/workspace
git clone http://github.com/defunkt/dotjs
cd dotjs
rake install

# ego xcode theme
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
cd ~/Library/Developer/Xcode/UserData/FontAndColorThemes
curl -O http://developers.enormego.com/assets/egotheme/EGOv2.dvtcolortheme

# sudo env ARCHFLAGS="-arch x86_64" gem install mysql2 --no-rdoc --no-ri -- --with-mysql-config `which mysql_config`

# Start passenger standalone for all applications
# cd ~/workspace && sudo passenger start -p 80 -u (some_unprivileged_username)

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
