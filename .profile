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
export GOPATH=~/.local/share/go
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

[ -f "$HOME/.secret" ] && source "$HOME/.secret"
