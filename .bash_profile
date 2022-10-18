#
# ~/.bash_profile
#

# ---------- env -----------
# User configuration
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim
export FILEMANAGER=pcmanfm
export MYVIMRC=~/.config/nvim/init.vim

# wine
export WINEPREFIX=~/.local/lib/wine-wechat/default

# vim lsp manager
export PATH=$PATH:~/.local/share/nvim/mason/bin/

# fzf config
export FZF_COMPLETION_TRIGGER="?"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,winDesk,.npm} --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

# nnn
export NNN_PLUG='i:imgview;p:preview-tabbed;f:fzcd'
export NNN_BMS='w:~/Desktop/Wallpapers'
export NNN_SEL='/tmp/.sel'
export NNN_FIFO='/tmp/nnn.fifo'

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

# ---------- alias ----------
# proxy
# alias proxy='HTTPS_PROXY=socks5://127.0.0.1:1080'
alias proxy='ALL_PROXY=socks5://127.0.0.1:1080'

# nbfc
alias startnbfc='systemctl start nbfc'
alias stopnbfc='systemctl stop nbfc'
# ssh
alias ssharml='ssh tao@192.168.3.23'

# alias sshtrojan='ssh -l root 65.49.196.194 -p 29793'
alias sshtrojan='ssh -l root byt0723.xyz -p 29793'

# alias sshfrp='ssh root@42.192.5.238'
alias sshfrp='ssh root@frp.byt0723.xyz'
alias sshgit='ssh git@git.byt0723.xyz'

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
alias pam='pulsemixer'
# ranger
alias ra='ranger'
# neofetch
alias neo='neofetch'
# lazygit
alias lgit='lazygit'
# traslate
# alias tse='trans en:zh -speak'
# alias tsc='trans zh:en -speak'
alias tse='ydict -v 1 -c'
alias tsc='ydict'

#
# System Property
#
# samba
alias mcloud='sudo mount -o user=walter,pass=wangtao,uid=1000,gid=1000 //192.168.3.23/Cloud /home/tao/Cloud'
alias umcloud='sudo umount ~/Cloud'
alias mtemp='sudo mount /dev/sdb1 -o uid=1000,gid=1000 ~/winDesk/temp'
alias umtemp='sudo umount ~/winDesk/temp'
# clear trash(~/Trash)
alias del='sudo mv -t ~/Trash/'
alias cleartrash='sudo rm -rf ~/Trash/*'

#
# Quick Change Directory
#
# cd
alias cdnv='cd ~/.config/nvim/'
alias cdhub='cd ~/Documents/Github/'
alias cdlab='cd ~/Documents/GitLab/'
alias cdee='cd ~/Documents/Gitee/'
alias cddwm='cd ~/Documents/Github/dwm/'
alias cdst='cd ~/Documents/Github/st/'
alias cdblog='cd ~/Documents/Github/blog/'
alias cde5s='cd ~/Documents/Github/e5Code-Service/'
alias cde5='cd ~/Documents/Github/e5code/'
alias cdstudy='cd ~/Desktop/Study/'

#
# Quick Open Profile
#
# edit nvim config file
alias v='nvim'
alias sv='sudo -E nvim'
alias vc='nvim ~/.config/nvim/init.vim'
alias env='nvim ~/.bash_profile'
alias soenv='source ~/.bash_profile'
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
