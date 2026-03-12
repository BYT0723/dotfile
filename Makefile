update:
	@rsync -av /etc/environment ./
	@rsync -av ~/.profile ./
	@rsync -av ~/.aliases ./
	@rsync -av ~/.bashrc ./
	@rsync -av ~/.zshrc ./
	@rsync -av ~/.zimrc ./
	@rsync -av ~/.Xresources ./
	@rsync -av ~/.config/starship.toml ./.config/
	@rsync -av ~/.config/screenkey.json ./.config/
	@rsync -av --delete ~/.config/dwm/       ./.config/dwm/
	@rsync -av --delete ~/.config/kitty/     ./.config/kitty/
	@rsync -av --delete ~/.config/mpd/       ./.config/mpd/
	@rsync -av --delete ~/.config/mpv/       ./.config/mpv/
	@rsync -av --delete ~/.config/rmpc/ 		 ./.config/rmpc/
	@rsync -av --delete ~/.config/dunst/     ./.config/dunst/
	@rsync -av --delete ~/.config/zathura/   ./.config/zathura/
	@rsync -av --delete ~/.config/yazi/      ./.config/yazi/ --exclude 'plugins/'
	@rsync -av --delete ~/.config/yazi_wallpaper/      ./.config/yazi_wallpaper/
	@rsync -av --delete ~/.config/aerc/      ./.config/aerc/
	@rsync -av --delete ~/.config/lazygit/config.yml   ./.config/lazygit/config.yml
	@rsync -av --delete ~/.notmuch-config    ./ || true
	@rsync -av --delete ~/.offlineimaprc     ./ || true
	@rsync -av --delete ~/.config/newsboat/  ./.config/newsboat/ || true
	@rsync -av --delete ~/.config/conky/     ./.config/conky/ || true
	@rsync -av --delete  /etc/sing-box/			 ./sing-box/client/ || true
	@mkdir -p ./.local/share/easyeffects
	@rsync -av --delete ~/.local/share/easyeffects/input/  ./.local/share/easyeffects/input/
	@rsync -av --delete ~/.local/share/easyeffects/output/ ./.local/share/easyeffects/output/
	@mkdir -p ./.config/tmux
	@rsync -av ~/.config/tmux/tmux.conf ./.config/tmux/ --exclude 'plugins/'
	@crontab -l > crontab

install:
	@sudo rsync -av --delete ./environment /etc/environment
	# 同理，把 ./. 同步回 ~/
	@rsync -av --delete ./.bash_profile ~/.bash_profile
	@rsync -av --delete ./.Xresoures ~/.Xresoures
	@rsync -av --delete ./.bashrc ~/.bashrc
	@rsync -av --delete ./.zshrc ~/.zshrc
	@rsync -av --delete ./.zimrc ~/.zimrc
	@rsync -av --delete ./.offlineimaprc ~/.offlineimaprc
	@rsync -av --delete ./.notmuch-config ~/.notmuch-config
	@rsync -av --delete ./.config/ ~/.config/
	@rsync -av --delete ./.local/share/ ~/.local/share/
	@(cat crontab) | crontab -
