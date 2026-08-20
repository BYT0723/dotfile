#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

PS1='[\u@\h \W]\$ '
