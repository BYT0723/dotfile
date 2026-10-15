RSYNC = rsync -avh
DRY ?= --dry-run   # 默认安全：只预览

# =========================
# 需要强一致同步的 config 子目录
# =========================
CONFIG_DIRS = \
	aerc \
	autorandr \
	conky \
	dunst \
	dwm \
	fcitx5 \
	flameshot \
	gtk-2.0 \
	gtk-3.0 \
	gtk-4.0 \
	jellyfin-mpv-shim \
	kitty \
	mpd \
	mpv \
	newsboat \
	opencode \
	pcmanfm \
	pipewire \
	qt6ct \
	rmpc \
	tmux \
	wireplumber \
	yazi \
	yazi_wallpaper \
	zathura

# =========================
# update: 系统 → 仓库
# =========================
update:
	@echo "==> update system -> repo"

	@mkdir -p ./sing-box/client
	@sudo $(RSYNC) /etc/sing-box/ ./sing-box/client/ 2>/dev/null || true
	@sudo chown -R $(shell id -u):$(shell id -g) ./sing-box/client/
	@chmod 0755 ./sing-box/client
	@chmod 0644 ./sing-box/client/*

	@$(RSYNC) ~/.xprofile ./
	@$(RSYNC) ~/.profile ./
	@$(RSYNC) ~/.aliases ./
	@$(RSYNC) ~/.secret ./
	@$(RSYNC) ~/.bashrc ./
	@$(RSYNC) ~/.zshrc ./
	@$(RSYNC) ~/.zimrc ./

	@mkdir -p ./.config

	@for dir in $(CONFIG_DIRS); do \
		echo "sync $$dir"; \
		$(RSYNC) --delete ~/.config/$$dir/ ./.config/$$dir/ 2>/dev/null || true; \
	done

	@$(RSYNC) ~/.config/starship.toml ./.config/ 2>/dev/null || true
	@$(RSYNC) ~/.config/screenkey.json ./.config/ 2>/dev/null || true

	@mkdir -p ./.local/share/easyeffects
	@$(RSYNC) ~/.local/share/easyeffects/input/  ./.local/share/easyeffects/input/ 2>/dev/null || true
	@$(RSYNC) ~/.local/share/easyeffects/output/ ./.local/share/easyeffects/output/ 2>/dev/null || true

	@mkdir -p ./.local/share/fcitx5/rime
	@$(RSYNC) ~/.local/share/fcitx5/rime/*.custom.yaml ./.local/share/fcitx5/rime/ 2>/dev/null || true

	@crontab -l > crontab 2>/dev/null || true

	@mkdir -p ./media-scraping
	@$(RSYNC) ~/Applications/media-scraping/docker-compose.yml ./media-scraping/docker-compose.yml 2>/dev/null || true
	@$(RSYNC) ~/Applications/media-scraping/open.sh ./media-scraping/open.sh 2>/dev/null || true
	@$(RSYNC) ~/Applications/media-scraping/launch.sh ./media-scraping/launch.sh 2>/dev/null || true

	@pacman -Qqe > pkglist.txt
	@paru -Qqm > aurlist.txt 2>/dev/null || true

# =========================
# 需要随 install 同步到 ~/ 的 dotfile 文件
# =========================
DOTFILES = .xprofile .profile .aliases .bashrc .zshrc .zimrc .secret

# =========================
# 前置检查：仓库文件必须已解密 (git-crypt unlock)
# =========================
check-decrypted:
	@if head -c 8 ./.secret 2>/dev/null | grep -q GITCRYPT; then \
		echo "✗ 仓库仍为 git-crypt 密文，请先: git-crypt unlock ~/.dotfile-crypt.key"; \
		exit 1; \
	fi

# =========================
# install: 仓库 → 系统（安全模式，不删除目标端多余文件）
# =========================
install: check-decrypted
	@echo "==> install SAFE"

	@sudo mkdir -p /etc/sing-box
	@sudo $(RSYNC) ./sing-box/client/ /etc/sing-box/

	@for f in $(DOTFILES); do $(RSYNC) ./$$f ~/$$f; done

	@$(RSYNC) ./.config/ ~/.config/
	@$(RSYNC) ./.local/share/easyeffects/ ~/.local/share/easyeffects/
	@$(RSYNC) ./.local/share/fcitx5/rime/ ~/.local/share/fcitx5/rime/

	@crontab crontab 2>/dev/null || true

	@mkdir -p ~/Applications/media-scraping
	@$(RSYNC) ./media-scraping/docker-compose.yml ~/Applications/media-scraping/docker-compose.yml 2>/dev/null || true
	@$(RSYNC) ./media-scraping/open.sh ~/Applications/media-scraping/open.sh 2>/dev/null || true
	@$(RSYNC) ./media-scraping/launch.sh ~/Applications/media-scraping/launch.sh 2>/dev/null || true


# =========================
# install-force（默认 dry-run，防误删）
# 真正执行: make install-force DRY=
# =========================
install-force: check-decrypted
	@echo "==> install FORCE (dry-run default)"

	@sudo mkdir -p /etc/sing-box
	@sudo $(RSYNC) $(DRY) --delete ./sing-box/client/ /etc/sing-box/

	@for dir in $(CONFIG_DIRS); do \
		echo "force sync $$dir"; \
		$(RSYNC) $(DRY) --delete ./.config/$$dir/ ~/.config/$$dir/; \
	done

	@for f in $(DOTFILES); do $(RSYNC) $(DRY) ./$$f ~/$$f; done

	@echo "==> dry-run done. use DRY= to apply"


# =========================
# diff 预览整个 config
# =========================
diff:
	@rsync -avnc ./.config/ ~/.config/
