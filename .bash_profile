#
# ~/.bash_profile
#

# ----------- system environments -----------
# GTK_IM_MODULE=fcitx
# QT_IM_MODULE=fcitx
# XMODIFIERS=@im=fcitx
# SDL_IM_MODULE=fcitx
# GLFW_IM_MODULE=ibus
#
# http_proxy=http://127.0.0.1:8118
# https_proxy=http://127.0.0.1:8118
# all_proxy=http://127.0.0.1:8118
#
# # fix Menu disappearing in Java program in Dwm
export _JAVA_AWT_WM_NONREPARENTING=1
#
export WINEPREFIX=~/.local/lib/wine-wechat/default/

# ---------- env -----------
# User configuration
export BROWSER=firefox
export EDITOR=nvim
export FILEMANAGER=pcmanfm
export MYVIMRC=~/.config/nvim/init.vim
export TERM=xterm-256color

# git
export GIT_TERMINAL_PROMPT=1

# fzf config
export FZF_COMPLETION_TRIGGER="?"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,winDesk,.npm} --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

# nnn
export NNN_PLUG='i:imgview;p:preview-tabbed;t:preview-tui;f:fzcd'
export NNN_BMS='w:~/Desktop/Wallpapers'
export NNN_SEL='/tmp/.sel'
export NNN_FIFO='/tmp/nnn.fifo'

export PATH=$PATH:~/.local/bin
export PATH=$PATH:/opt/net.downloadhelper.coapp/bin

# go env
export GOROOT=/usr/lib/go
export GO111MODULE=on
export CGO_ENABLED=0
export GOPROXY=https://goproxy.cn/
export GOPATH=~/GoPath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# rust env
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export PATH=$PATH:~/.cargo/bin

# flutter
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# android
export ANDPORD_HOME=/opt/android-sdk
export PATH=$PATH:$ANDPORD_HOME/platform-tools

# nodejs
export NPM_PACKAGES=~/.npm-packages
export NODE_PATH=$NPM_PACKAGES/lib/node_modules:$NODE_PATH
export PATH=$PATH:$NPM_PACKAGES/bin

# ---------- alias ----------
alias tt="time zsh -i -c exit"
# protect
alias rm='gio trash'
# proxy
alias proxy='ALL_PROXY=socks5://127.0.0.1:1080'
alias noproxy='http_proxy="" https_proxy="" all_proxy=""'

alias pac='sudo -E nvim /etc/privoxy/pac.action'

# nbfc
alias startnbfc='systemctl start nbfc_service'
alias stopnbfc='systemctl stop nbfc_service'
alias nbfcconf='sudo -E nvim "/opt/nbfc/Configs/Xiaomi Mi Book (TM1613, TM1703).xml"'
# ssh
alias sshpi='ssh 192.168.3.8'

# alias sshtrojan='ssh -l root 65.49.196.194 -p 29793'
alias sshtrojan='ssh -l root byt0723.xyz -p 29793'

# live
alias danmu="surf 'https://blc.lolicon.app/live.html#face=false&room=23970948'"

#
# Start APP
#
# ncmpcpp
alias nm='ncmpcpp'
alias np='ncpamixer'
# ranger
alias ra='ranger'
# nnn
alias nnn='nnn -de'
# neofetch
alias neo='neofetch'
# git
alias lg='lazygit'
# docker
alias ldk='lazydocker'
alias dkc='docker-compose'
# traslate
alias ts='ydict -v 1 -c'
alias tse='trans en:zh -speak'
alias tsc='trans zh:en -speak'

#
# System Property
#
# samba
# alias mcloud='sudo mount -t cifs -o user=walter,pass=wangtao,uid=1000,gid=1000 //192.168.3.8/Cloud /home/walter/disk/cloud'
alias mcloud='sudo mount -t cifs -o user=walter,pass=wangtao,uid=1000,gid=1000 //raspberrypi.local/Cloud /home/walter/disk/cloud'
alias umcloud='sudo umount ~/disk/cloud'
alias mtemp='sudo mount /dev/sdb1 -o uid=1000,gid=1000 ~/winDesk/temp'
alias umtemp='sudo umount ~/disk/temp'

#
# Quick Change Directory
#
# cd
alias cdnv='cd ~/.config/nvim/'
alias cdhub='cd ~/Workspace/Github/'
alias cddwm='cd ~/Workspace/Github/dwm/'
alias cdst='cd ~/Workspace/Github/st/'
alias cdblog='cd ~/Workspace/Github/blog/'
alias cdstudy='cd ~/Desktop/Study/'

#
# Quick Open Profile
#
# edit nvim config file
alias v='nvim'
alias sv='sudo -E nvim'
alias profile='nvim ~/.bash_profile'
alias soprofile='source ~/.bash_profile'
alias pcconf='nvim ~/.dwm/configs/picom.conf'

# wether
alias weather="curl -H 'Accept-Language:'$(echo $LANG | awk -F '_' '{print $1}') 'wttr.in'"

# display
alias layoutAbove="xrandr --output eDP1 --auto --output HDMI2 --auto --mode 2560x1440 --above eDP1"
alias layoutRight="xrandr --output eDP1 --auto --output HDMI2 --auto --mode 2560x1440 --right-of eDP1"
alias layoutMirror="xrandr --output eDP1 --auto --output HDMI2 --auto --mode 1920x1080 --same-as eDP1"
alias layoutOnlyHDMI="xrandr --output eDP1 --off --output HDMI2 --auto --mode 2560x1440"
alias layoutOnlyDP="xrandr --output HDMI2 --off --output eDP1 --auto --mode 1920x1080 "

alias wallpapers="cd ~/.local/share/Steam/steamapps/workshop/content/431960/"
