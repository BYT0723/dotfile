#
# ~/.bash_profile
#

# proxy
alias proxy='HTTPS_PROXY=socks5://127.0.0.1:1080'
#
# Start Server
# 
# nbfc
alias startnbfc='systemctl start nbfc'
alias stopnbfc='systemctl stop nbfc'
# ssh
alias ssharml='ssh tao@192.168.3.23'
alias ssharm='ssh tao@frp.byt0723.xyz -p 222'

# alias sshtrojan='ssh -l root 65.49.196.194 -p 29793'
alias sshtrojan='ssh -l root byt0723.xyz -p 29793'
# alias sshfrp='ssh root@42.192.5.238'
alias sshfrp='ssh root@frp.byt0723.xyz'

alias sshgit='ssh git@git.byt0723.xyz'

# system
alias light='sudo chmod 760 /sys/class/backlight/intel_backlight/brightness'
alias touchOn="synclient TouchpadOff=0"
alias touchOff="synclient TouchpadOff=1"

#
# Quickly Change Bluetooth Device
#
# DC:2C:26:EA:A7:5A  ---  RK-Keyboard 5.1
# 38:EC:0D:7C:9F:E3  ---  byt's airpods
# 5D:CB:6E:46:C3:30  ---  B16
# B8:90:47:00:61:7B  ---  ios-tao
alias cpods='bluetoothctl connect 38:EC:0D:7C:9F:E3'
alias dcpods='bluetoothctl disconnect 38:EC:0D:7C:9F:E3'
alias cb16='bluetoothctl connect 5D:CB:6E:46:C3:30'
alias dcb16='bluetoothctl disconnect 5D:CB:6E:46:C3:30'

#
# Start APP
#
# ncmpcpp
alias nm='ncmpcpp'
# ncpamixer
alias np='ncpamixer'
# ranger
alias ra='ranger'
# neofetch
alias neo='neofetch'
# lazygit
alias lgit='lazygit'
# traslate
alias tse='trans en:zh -speak'
alias tsc='trans zh:en -speak'

#
# System Property
#
# samba
alias mcloud='sudo mount -o user=tao,pass=wangtao,uid=1000,gid=1000 //192.168.3.23/Cloud /home/tao/Cloud'
alias umcloud='sudo umount /home/tao/Cloud'
alias mtemp='sudo mount /dev/sdb1 -o uid=1000,gid=1000 /home/tao/winDesk/temp'
alias umtemp='sudo umount /home/tao/winDesk/temp'
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

# edit tmux config file
alias tmuxconf='nvim ~/.tmux.conf'

# edit .profile
alias env='nvim ~/.profile'
alias soenv='source ~/.profile'

# edit .bash_profile
alias bashprofile='nvim ~/.bash_profile'

# edit hosts
alias hosts='sudo -E nvim /etc/hosts'

# edit note
alias note='nvim ~/.note'

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

alias wallpapers="cd /home/tao/winDesk/G/Steam/steamapps/workshop/content/431960/"

# [[ -f ~/.bashrc ]] && . ~/.bashrc
