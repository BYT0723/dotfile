zimfw() { source /home/walter/.zim/zimfw.zsh "${@}" }
zmodule() { source /home/walter/.zim/zimfw.zsh "${@}" }
typeset -g _zim_fpath=(/home/walter/.zim/modules/git/functions /home/walter/.zim/modules/utility/functions /home/walter/.zim/modules/duration-info/functions /home/walter/.zim/modules/git-info/functions /home/walter/.zim/modules/zsh-completions/src)
fpath=(${_zim_fpath} ${fpath})
autoload -Uz -- git-alias-lookup git-branch-current git-branch-delete-interactive git-branch-remote-tracking git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove mkcd mkpw duration-info-precmd duration-info-preexec coalesce git-action git-info
source /home/walter/.zim/modules/environment/init.zsh
source /home/walter/.zim/modules/git/init.zsh
source /home/walter/.zim/modules/input/init.zsh
source /home/walter/.zim/modules/termtitle/init.zsh
source /home/walter/.zim/modules/utility/init.zsh
source /home/walter/.zim/modules/duration-info/init.zsh
source /home/walter/.zim/modules/asciiship/asciiship.zsh-theme
source /home/walter/.zim/modules/completion/init.zsh
source /home/walter/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/walter/.zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
source /home/walter/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/walter/.zim/modules/powerlevel10k/powerlevel10k.zsh-theme
