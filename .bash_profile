#
# ~/.bash_profile
#

# ---------- env -----------
# User configuration
export BROWSER=firefox
export EDITOR=nvim
export VISUAL=neovide
export FILEMANAGER=pcmanfm
export TERMINAL=alacritty
export TERM=xterm-256color

# wine
# export WINEPREFIX=~/.local/lib/wine-wechat/default/

# git
export GIT_TERMINAL_PROMPT=1

# fzf config
export FZF_COMPLETION_TRIGGER="?"

export PATH=$PATH:~/.local/bin
export PATH=$PATH:/opt/net.downloadhelper.coapp/bin

# go env
export GOROOT=/usr/lib/go
export GO111MODULE=on
export CGO_ENABLED=1
export GOPROXY=https://goproxy.cn/
export GOPATH=~/GoPath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# rust env
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
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

alias pac='sudo -E nvim /etc/sing-box/rules/geosite-proxy.json'

#
# Start APP
#
# ncmpcpp
alias nm='ncmpcpp'
alias np='ncpamixer'
# neofetch
alias neo='neofetch'
# git
alias lg='lazygit'
# docker
alias ld='lazydocker'
alias le='yazi'
alias lmail='aerc'
# translate
alias ts='ydict -v 1 -c'
alias tse='trans en:zh -speak'
alias tsc='trans zh:en -speak'

#
# System Property
#
# samba

# alias mcloud='sudo mount -t cifs -o user=walter,pass=wangtao,uid=1000,gid=1000,soft //192.168.3.51/private ~/disks/private'
# alias umcloud='sudo umount ~/disks/private'
# alias mresource='sudo mount -t cifs -o user=walter,pass=wangtao,uid=1000,gid=1000,soft //192.168.3.51/share ~/disks/resource'
# alias umresource='sudo umount ~/disks/resource'
# alias mshare='sudo mount -t cifs -o user=walter,pass=wangtao,uid=1000,gid=1000 //raspberry.local/private ~/disks/private'
# alias umshare='sudo umount ~/disks/private'

#
# Quick Open Profile
#
# edit nvim config file
alias v='nvim'
alias sv='sudo -E nvim'
alias profile='nvim ~/.bash_profile'
alias secret='nvim ~/.bash_secret'
alias pcconf='nvim ~/.dwm/configs/picom.conf'

# weather
alias weather="curl -H 'Accept-Language:'$(echo $LANG | awk -F '_' '{print $1}') 'wttr.in'"

alias rav='bash ~/.dwm/tools/random_file.sh ~/disks/private/share/'
alias rv='bash ~/.dwm/tools/random_file.sh'
