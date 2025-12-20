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
# export WINEPREFIX=~/.local/lib/wine-wechat/default/

# ---------- env -----------
# User configuration
export BROWSER=firefox
export EDITOR=nvim
export FILEMANAGER=pcmanfm
export MYVIMRC=~/.config/nvim/init.vim
export TERM=xterm-256color

# AI
export OPENAI_API_KEY=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
export GEMINI_API_KEY=AIzaSyBhVreStZCjgKj07vGNN9IkNClQHzJWHs0
export DEEPSEEK_API_KEY=sk-01950b4296174ce7b237ee7f158f5aaa

# git
export GIT_TERMINAL_PROMPT=1

# fzf config
export FZF_COMPLETION_TRIGGER="?"
# export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,winDesk,.npm} --type f"
# export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
#   --highlight-line \
#   --info=inline-right \
#   --ansi \
#   --layout=reverse \
#   --border=none
#   --color=bg+:#2d3f76 \
#   --color=bg:#1e2030 \
#   --color=border:#589ed7 \
#   --color=fg:#c8d3f5 \
#   --color=gutter:#1e2030 \
#   --color=header:#ff966c \
#   --color=hl+:#65bcff \
#   --color=hl:#65bcff \
#   --color=info:#545c7e \
#   --color=marker:#ff007c \
#   --color=pointer:#ff007c \
#   --color=prompt:#65bcff \
#   --color=query:#c8d3f5:regular \
#   --color=scrollbar:#589ed7 \
#   --color=separator:#ff966c \
#   --color=spinner:#ff007c \
# "

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

# nbfc
alias startnbfc='systemctl start nbfc_service'
alias stopnbfc='systemctl stop nbfc_service'
alias nbfcconf='sudo -E nvim "/opt/nbfc/Configs/Xiaomi Mi Book (TM1613, TM1703).xml"'

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

# alias mcloud='sudo mount -t cifs -o user=walter,pass=wangtao,uid=1000,gid=1000,soft //192.168.3.51/private /home/walter/disks/private'
# alias umcloud='sudo umount ~/disks/private'
# alias mresource='sudo mount -t cifs -o user=walter,pass=wangtao,uid=1000,gid=1000,soft //192.168.3.51/share /home/walter/disks/resource'
# alias umresource='sudo umount ~/disks/resource'
# alias mshare='sudo mount -t cifs -o user=walter,pass=wangtao,uid=1000,gid=1000 //raspberry.local/private /home/walter/disks/private'
# alias umshare='sudo umount ~/disks/private'

#
# Quick Change Directory
#
# cd
alias cdnv='cd ~/.config/nvim/'
alias cdhub='cd ~/Workspace/Github/'
alias cddwm='cd ~/Workspace/Github/dwm/'
alias cdst='cd ~/Workspace/Github/st/'

#
# Quick Open Profile
#
# edit nvim config file
alias v='nvim'
alias sv='sudo -E nvim'
alias profile='nvim ~/.bash_profile'
alias pcconf='nvim ~/.dwm/configs/picom.conf'

# wether
alias weather="curl -H 'Accept-Language:'$(echo $LANG | awk -F '_' '{print $1}') 'wttr.in'"

alias wallpapers="cd ~/.local/share/Steam/steamapps/workshop/content/431960/"

alias rav='bash /home/walter/.dwm/tools/random_file.sh /home/walter/disks/private/share/'
alias rv='bash /home/walter/.dwm/tools/random_file.sh'
