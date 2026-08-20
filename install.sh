#!/bin/bash
# ╔══════════════════════════════════════════════════════════════╗
# ║            walter-arch-bootstrap                            ║
# ║            在裸 Arch Linux 上重建完整 dwm 桌面环境           ║
# ╚══════════════════════════════════════════════════════════════╝
#
# 用法:
#   ./install.sh              # 交互式选择安装阶段 (dialog UI)
#   ./install.sh --all        # 全自动安装所有阶段
#   ./install.sh --cn         # 启用国内镜像 (GitHub/archlinuxcn 加速)
#   ./install.sh --all --cn   # 全自动 + 国内镜像
#   ./install.sh --dry-run    # 预览模式，不实际执行
#   ./install.sh --help       # 显示帮助
#
# 设计原则:
#   1. 按依赖层次组织 — 先编译依赖，后软件清单，最后编译 dwm
#   2. 软件来源单一 — pkglist.txt/aurlist.txt (make update 导出)
#   3. 幂等 — pacman/paru 原生支持重复安装
#   4. 失败即停 — set -euo pipefail，哪步错报哪步
#   5. 先 dialog 后选阶段 — 安装 dialog 后展示 checklist UI
#
# 依赖层次:
#   Phase 0  → 前置检查 + paru + dialog + sing-box
#   Phase 1  → dwm 编译依赖 (X11 libs / imlib2 / fontconfig)
#   Phase 2  → 官方软件清单 (pkglist.txt)
#   Phase 3  → AUR 软件清单 (aurlist.txt)
#   Phase 4  → 编译安装 dwm
#   Phase 5  → 部署配置 (克隆仓库 → dotfile make install)
#   Phase 6  → 验证 (关键命令可执行性检查)

set -euo pipefail

# ═══════════════════════════════════════════════════════════
# 配置 — 如需定制请修改此处
# ═══════════════════════════════════════════════════════════
readonly DOTFILE_REPO="https://github.com/BYT0723/dotfile.git"
readonly DWM_REPO="https://github.com/BYT0723/dwm.git"
readonly SCRIPTS_REPO="https://github.com/BYT0723/scripts.git"
readonly CN_MIRROR="https://repo.archlinuxcn.org/\$arch"
readonly WORKDIR="/tmp/walter-bootstrap"
# GitHub 加速镜像 — 由 --cn 参数自动设置
# 国内用户可使用: https://ghfast.top/ 或 https://ghproxy.com/
GH_PROXY=""

# ANSI
readonly R='\033[0;31m' G='\033[0;32m' Y='\033[1;33m' C='\033[0;36m' B='\033[1m' N='\033[0m'

# ═══════════════════════════════════════════════════════════
# 工具函数
# ═══════════════════════════════════════════════════════════
say() { echo -e "${G}==>${N} $*"; }
warn() { echo -e "${Y}⚠${N}  $*"; }
die() {
	echo -e "${R}✗${N}  $*" >&2
	exit 1
}
phase() { echo -e "\n${C}══════${N} $* ${C}══════${N}"; }

# 验证用：检查命令是否存在 (Phase 6)
ok=0
fail=0
check() {
	if command -v "$1" &>/dev/null; then
		printf "  ${G}✓${N} %s\n" "$1"
		ok=$((ok + 1))
	else
		printf "  ${R}✗${N} %-30s %s\n" "$1" "${2:-}"
		fail=$((fail + 1))
	fi
}

clone_or_pull() {
	local repo="$1" dest="$2"
	# GitHub 加速代理 → 解决国内 github.com 不可达
	if [ -n "$GH_PROXY" ] && [[ "$repo" == https://github.com/* ]]; then
		repo="${GH_PROXY}${repo}"
	fi
	if [ -d "$dest/.git" ]; then
		say "更新: $dest"
		git -C "$dest" pull --ff-only
	else
		say "克隆: $repo → $dest"
		git clone "$repo" "$dest"
	fi
}

# 从清单文件安装 (pkglist.txt / aurlist.txt)
# 用法: install_from_list "标签" 清单文件 命令...
install_from_list() {
	local label="$1" list="$2"
	shift 2
	local -a cmd=("$@")
	if $DRY; then
		echo "  [DRY] ${cmd[*]} -S --noconfirm --needed - < $list"
	elif [ -s "$list" ]; then
		say "安装 $label: $list"
		"${cmd[@]}" -S --noconfirm --needed - < "$list"
	else
		warn "缺少 $list，跳过"
	fi
}

# pacman 包装 (编译依赖等少量硬编码包)
pkg() {
	if $DRY; then
		echo "  [DRY] sudo pacman -S --noconfirm --needed $*"
	else
		sudo pacman -S --noconfirm --needed "$@"
	fi
}

# ═══════════════════════════════════════════════════════════
# CLI 参数解析
# ═══════════════════════════════════════════════════════════
ALL=false DRY=false CN=false

for arg in "$@"; do
	case "$arg" in
	--all | -a) ALL=true ;;
	--dry-run | -n) DRY=true ;;
	--cn) CN=true ;;
	--help | -h)
		sed -n '2,29p' "$0"
		exit 0
		;;
	*) die "未知参数: $arg (--all | --dry-run | --cn | --help)" ;;
	esac
done

if $CN; then
	GH_PROXY="https://ghfast.top/"
	say "启用国内镜像 (GitHub 加速: ${GH_PROXY})"
fi
$DRY && warn "DRY-RUN 模式 — 仅打印操作，不修改系统"

# ═══════════════════════════════════════════════════════════
# Phase 0: 前置检查 + paru + dialog
# ═══════════════════════════════════════════════════════════
phase0() {
	phase "Phase 0: 前置检查与基础工具"

	$DRY || [ "$(id -u)" -ne 0 ] || die "请以普通用户运行，提权时脚本自动调用 sudo"
	command -v curl &>/dev/null || pkg curl
	command -v git &>/dev/null || pkg git
	$DRY || command -v pacman &>/dev/null || die "仅支持 Arch Linux"

	$DRY || sudo -v
	$DRY || mkdir -p "$WORKDIR"

	# dialog — 提供交互式 checklist UI
	if ! command -v dialog &>/dev/null && ! $DRY; then
		say "安装 dialog (交互式界面)"
		sudo pacman -S --noconfirm --needed dialog
	fi

	# archlinuxcn — 预编译 AUR 包 (paru, nerd-fonts, 等)
	if ! grep -q '\[archlinuxcn\]' /etc/pacman.conf 2>/dev/null; then
		say "启用 archlinuxcn 源"
		$DRY || echo -e "\n[archlinuxcn]\nServer = ${CN_MIRROR}" |
			sudo tee -a /etc/pacman.conf >/dev/null
	fi
	pkg archlinuxcn-keyring

	# paru — AUR helper
	if ! command -v paru &>/dev/null; then
		say "安装 paru (AUR helper)"
		if $DRY; then
			echo "  [DRY] 安装 paru"
		elif sudo pacman -S --noconfirm paru 2>/dev/null; then
			say "paru 安装完成 (archlinuxcn 预编译)"
		else
			warn "archlinuxcn 未提供 paru，从 AUR 构建..."
			pkg base-devel
			git clone https://aur.archlinux.org/paru.git "$WORKDIR/paru"
			(cd "$WORKDIR/paru" && makepkg -si --noconfirm)
			command -v paru &>/dev/null || die "paru 安装失败，请手动安装"
		fi
	fi

	# sing-box — 代理工具，提前安装以便后续 GitHub 操作走代理
	pkg sing-box
}

# ═══════════════════════════════════════════════════════════
# 阶段选择 (dialog checklist)
# ═══════════════════════════════════════════════════════════
ALL_PHASES="1 2 3 4 5 6"

declare -A PHASE_NAMES=(
	[1]="编译依赖       (dwm 构建所需的 X11/imlib2/fontconfig 库)"
	[2]="官方软件        (pkglist.txt)"
	[3]="AUR 软件        (aurlist.txt)"
	[4]="编译安装 dwm    (make clean install)"
	[5]="部署配置        (克隆仓库 → dotfile make install)"
	[6]="验证           (关键命令可执行性检查)"
)

select_phases() {
	if $ALL; then
		PHASES="$ALL_PHASES"
		return
	fi

	if ! command -v dialog &>/dev/null; then
		warn "dialog 不可用，默认全量安装"
		PHASES="$ALL_PHASES"
		return
	fi

	# 构建 dialog checklist 参数
	local args=()
	for i in 1 2 3 4 5 6; do
		args+=("$i" "${PHASE_NAMES[$i]}" "on")
	done

	local choice
	exec 3>&1
	choice=$(dialog --title " walter-arch-bootstrap " \
		--checklist "SPACE 选择/取消   ENTER 确认\n
按依赖层次组织的安装阶段，首次安装建议全选\n
取消(ESC) = 默认全量安装:" \
		0 0 0 "${args[@]}" 2>&1 1>&3) || true
	exec 3>&-

	if [ -z "$choice" ]; then
		say "未选择任何阶段，默认全量安装"
		PHASES="$ALL_PHASES"
	else
		PHASES=$(echo "$choice" | tr -d '"')
		say "已选择阶段: $PHASES"
	fi
}

# ═══════════════════════════════════════════════════════════
# Phase 1: dwm 编译依赖
# ═══════════════════════════════════════════════════════════
phase1() {
	phase "Phase 1: dwm 编译依赖"

	pkg base-devel
	#   → make, gcc, pkgconf  (dwm/Makefile)
	pkg libx11
	#   → 核心 Xlib, dwm.c 链接 -lX11
	pkg libxinerama
	#   → 多显示器支持, config.mk -DXINERAMA -lXinerama
	pkg libxft
	#   → FreeType 字体渲染, drw.c 链接 -lXft
	pkg libxrender
	#   → X Render 扩展 (alpha/透明/圆角), drw.c 链接 -lXrender
	pkg imlib2
	#   → 窗口图标加载, drw.c/dwm.c 链接 -lImlib2
	pkg fontconfig
	#   → 字体发现与匹配, drw.c 链接 -lfontconfig
	pkg freetype2
	#   → 字体光栅化, libxft 底层依赖
}

# ═══════════════════════════════════════════════════════════
# Phase 2: 官方软件清单
# Phase 3: AUR 软件清单
# ═══════════════════════════════════════════════════════════
phase2() {
	phase "Phase 2: 官方软件 (pkglist.txt)"
	install_from_list "官方软件" pkglist.txt sudo pacman
}

phase3() {
	phase "Phase 3: AUR 软件 (aurlist.txt)"
	install_from_list "AUR 软件" aurlist.txt paru
}

# ═══════════════════════════════════════════════════════════
# Phase 4: 编译安装 dwm
# ═══════════════════════════════════════════════════════════
phase4() {
	phase "Phase 4: 编译安装 dwm"

	local dwm_src
	if [ -f "config.mk" ] && [ -f "dwm.c" ] && [ -f "config.h" ]; then
		# 从 dwm 源码目录执行 install.sh，直接使用本地源码
		dwm_src="$PWD"
		say "使用当前目录 dwm 源码: $dwm_src"
	elif $DRY; then
		dwm_src="$WORKDIR/dwm"
	else
		clone_or_pull "$DWM_REPO" "$WORKDIR/dwm"
		dwm_src="$WORKDIR/dwm"
	fi

	if $DRY; then
		echo "  [DRY] make -C $dwm_src clean install"
	else
		say "编译 dwm..."
		make -C "$dwm_src" clean install
		say "dwm 安装完成 → $(command -v dwm)"
	fi
}

# ═══════════════════════════════════════════════════════════
# Phase 5: 部署配置
# ═══════════════════════════════════════════════════════════
phase5() {
	phase "Phase 5: 部署配置"
	local dotfile_dir

	# ── dwm 脚本 (~/.dwm/) ──
	if $DRY; then
		echo "  [DRY] git clone $SCRIPTS_REPO ~/.dwm"
	else
		clone_or_pull "$SCRIPTS_REPO" "$HOME/.dwm"
	fi

	# ── dotfile 配置 ──
	if [ -f "Makefile" ] && [ -f "pkglist.txt" ]; then
		# 从 dotfile 仓库内运行，直接使用当前目录
		say "使用当前 dotfile 仓库: $PWD"
		dotfile_dir="$PWD"
	elif $DRY; then
		dotfile_dir="$WORKDIR/dotfile"
	else
		clone_or_pull "$DOTFILE_REPO" "$WORKDIR/dotfile"
		dotfile_dir="$WORKDIR/dotfile"
	fi

	if $DRY; then
		echo "  [DRY] make -C $dotfile_dir install"
		echo "  [DRY] zimfw install"
	else
		say "部署 dotfile 配置 (rsync → \$HOME)..."
		make -C "$dotfile_dir" install

		# Zim 插件
		if command -v zimfw &>/dev/null; then
			say "安装/更新 Zim 插件..."
			zimfw install
		fi

		# Shell 切换（可能需要手动输入密码）
		if [ "$SHELL" != "$(command -v zsh)" ]; then
			say "设置默认 Shell → zsh (chsh 可能需要手动输入密码)"
			chsh -s "$(command -v zsh)"
		fi
	fi
}

# ═══════════════════════════════════════════════════════════
# Phase 6: 验证
# ═══════════════════════════════════════════════════════════
phase6() {
	phase "Phase 6: 验证"

	$DRY && {
		echo "  [DRY] 跳过验证"
		return
	}

	ok=0
	fail=0

	check dwm "dwm 未安装 → Phase 4 可能失败"
	check kitty "→ ~/.dwm/dwm-launcher.sh"
	check rofi "→ ~/.dwm/dwm-launcher.sh"
	check picom "→ ~/.dwm/autostart.sh"
	check dunst "→ ~/.dwm/autostart.sh"
	check paru "→ AUR helper"
	check jq "→ 被多个脚本依赖"
	check feh "→ ~/.dwm/tools/wallpaper.sh"
	check mpv "→ ~/.dwm/tools/wallpaper.sh"
	check ffmpeg "→ ~/.dwm/tools/screencast.sh"
	check fcitx5 "→ ~/.dwm/autostart.sh"
	check zsh "→ Shell"
	check starship "→ Shell 提示符"
	check tmux "→ 终端复用器"

	echo ""
	echo "  通过: $ok   失败: $fail"
	[ "$fail" -eq 0 ] || warn "有 $fail 项未通过，请查看上方 ✗ 标记"
}

# ═══════════════════════════════════════════════════════════
# 主流程
# ═══════════════════════════════════════════════════════════
main() {
	echo -e "${B}"
	echo "  ╔══════════════════════════════════╗"
	echo "  ║   walter-arch-bootstrap         ║"
	echo "  ║   裸 Arch → 完整 dwm 桌面环境    ║"
	echo "  ╚══════════════════════════════════╝"
	echo -e "${N}"

	phase0 # 前置检查 + 安装 paru/dialog
	select_phases

	local phases_arr=($PHASES)
	for p in "${phases_arr[@]}"; do
		"phase${p}"
	done

	echo ""
	echo -e "${G}══════════════════════════════════════${N}"
	echo -e "${G}  完成!${N}"
	echo ""
	echo "  下一步:"
	echo "    • 确认 ~/.dwm/autostart.sh 中的启动项"
	echo "    • startx 启动 dwm"
	echo "    • 或配置 SDDM: systemctl enable sddm"
	echo ""
}

main