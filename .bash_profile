#
# ~/.bash_profile
#

# ---------- env -----------
# User configuration
export BROWSER=firefox
export EDITOR=nvim
export FILEMANAGER=pcmanfm
export TERMINAL=kitty
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
alias np='ncpamixer'
alias fetch='fastfetch'
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

alias cal='cal -s'
alias ccal='ccal -u'

#
# Quick Open Profile
#
# edit nvim config file
alias v='nvim'
alias sv='sudo -E nvim'
alias profile='nvim ~/.bash_profile'
alias secret='nvim ~/.bash_secret'
alias pcconf='nvim ~/.config/dwm/picom.conf'

# weather
alias weather="curl -H 'Accept-Language:'$(echo $LANG | awk -F '_' '{print $1}') 'wttr.in'"

# cursor setting
alias c="printf '\e[6 q'"

# xauth env update
alias uenv='export XAUTHORITY=$(echo /tmp/xauth_*)'

alias rv='bash ~/.dwm/tools/random_file.sh'

alias wallpapers='cd ~/.local/share/Steam/steamapps/workshop/content'
