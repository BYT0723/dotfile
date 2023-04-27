#
# ~/.bash_profile
#

# ---------- env -----------
# User configuration
export BROWSER=firefox
export EDITOR=nvim
export FILEMANAGER=pcmanfm
export MYVIMRC=~/.config/nvim/init.vim
export TERM=xterm-256color

# wine
export WINEPREFIX=~/.local/lib/wine-wechat/default

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

# go env
export GOROOT=/usr/lib/go
export GO111MODULE=on
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
export PATH=$NPM_PACKAGES/bin:$PATH

# cuda
export CUDA_PATH=/opt/cuda
export PATH=$PATH:$CUDA_PATH/bin
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

# ---------- alias ----------
alias tt="time zsh -i -c exit"
# proxy
alias proxy='ALL_PROXY=socks5://127.0.0.1:1080'
alias noproxy='http_proxy="" https_proxy=""'
alias shadowscoks-start='sudo sslocal -c /etc/shadowsocks.json -d start'
alias shadowscoks-stop='sudo sslocal -c /etc/shadowsocks.json -d stop'

alias pac='sudo -E nvim /etc/privoxy/pac.action'

# nbfc
alias startnbfc='systemctl start nbfc'
alias stopnbfc='systemctl stop nbfc'
alias nbfcconf='sudo -E nvim "/opt/nbfc/Configs/Xiaomi Mi Book (TM1613, TM1703).xml"'
# ssh
alias sshpi='ssh 192.168.3.8'

# alias sshtrojan='ssh -l root 65.49.196.194 -p 29793'
alias sshtrojan='ssh -l root byt0723.xyz -p 29793'

# alias sshfrp='ssh root@42.192.5.238'
alias sshfrp='ssh root@frp.byt0723.xyz'
alias sshgit='ssh git@git.byt0723.xyz'

# live
# alias danmu="surf 'https://blc.lolicon.app/live.html#face=true&room=23970948'"
alias danmu="bilibili-live-tui -c /home/walter/Workspace/Github/bilibili_live_tui/themes/simple.toml"

#
# Quickly Change Bluetooth Device
#
# DC:2C:26:EA:A7:5A  ---  RK-Keyboard 5.1
# 38:EC:0D:7C:9F:E3  ---  byt's airpods
# 5D:CB:6E:46:C3:30  ---  B16
# B8:90:47:00:61:7B  ---  ios-tao
# 5A:FD:1C:35:B4:FA  ---  micro
alias cpods='bluetoothctl connect 38:EC:0D:7C:9F:E3'
alias dcpods='bluetoothctl disconnect 38:EC:0D:7C:9F:E3'
alias cmic='bluetoothctl connect 5A:FD:1C:35:B4:FA'
alias dcmic='bluetoothctl disconnect 5A:FD:1C:35:B4:FA'

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

# note
alias note='cat ~/.note'

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
alias vc='nvim ~/.config/nvim/init.vim'
alias profile='nvim ~/.bash_profile'
alias soprofile='source ~/.bash_profile'
alias pcconf='nvim ~/.dwm/configs/picom.conf'

# edit tmux config file
alias tmuxconf='nvim ~/.tmux.conf'

# execute api test
alias api="~/APP/api.sh"

# wether
alias weather="curl http://wttr.in"

# display
alias layoutAbove="xrandr --output eDP1 --auto --output HDMI2 --auto --mode 2560x1440 --above eDP1"
alias layoutRight="xrandr --output eDP1 --auto --output HDMI2 --auto --mode 2560x1440 --right-of eDP1"
alias layoutMirror="xrandr --output eDP1 --auto --output HDMI2 --auto --mode 1920x1080 --same-as eDP1"
alias layoutOnlyHDMI="xrandr --output eDP1 --off --output HDMI2 --auto --mode 2560x1440"
alias layoutOnlyDP="xrandr --output HDMI2 --off --output eDP1 --auto --mode 1920x1080 "

alias wallpapers="cd ~/winDesk/G/Steam/steamapps/workshop/content/431960/"
