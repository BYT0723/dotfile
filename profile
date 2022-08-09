export GTK_IM_MODULE DEFAULT=fcitx
export QT_IM_MODULE  DEFAULT=fcitx5
export XMODIFIERS    DEFAULT=\@im=fcitx
export INPUT_METHOD  DEFAULT=fcitx
export SDL_IM_MODULE DEFAULT=fcitx
export GLFW_IM_MODULE DEFAULT=ibus

export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim
export TERMINAL=st
export FILEMANAGER=pcmanfm
export MYVIMRC=~/.config/nvim/init.vim

# proxy
# export HTTP_PROXY=http://127.0.0.1:8889
# export HTTPS_PROXY=http://127.0.0.1:8889

# nvim markdown preview
export INSTANT_MARKDOWN_OPEN_TO_THE_WORLD=1
export INSTANT_MARKDOWN_ALLOW_UNSAFE_CONTENT=1

# fzf config
export FZF_COMPLETION_TRIGGER="?"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,winDesk,.npm} --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

# go env
export GOROOT=/usr/lib/go
export GO111MODULE=on
export GOPROXY=https://goproxy.cn/
export GOPATH=/home/tao/GoPath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# cuda
export PATH=$PATH:/opt/cuda/bin

# java env
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk/

# rustup
# export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
# export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

# Maven
export M2_HOME=/opt/maven

# kubeflow
export KF_NAME=kubeflow-demo
export BASE_DIR=/home/tao/workspace/kubeflow
export KF_DIR=${BASE_DIR}/${KF_NAME}
export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v0.7-branch/kfdef/kfctl_k8s_istio.0.7.1.yaml"
