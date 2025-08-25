update:
	@rsync -av ~/.bash_profile ./
	@rsync -av ~/.zshrc ./
	@rsync -av ~/.zimrc ./
	@rsync -av ~/.config/starship.toml ./.config/
	@rsync -av ~/.config/screenkey.json ./.config/
	@rsync -av --delete ~/.config/alacritty/ ./.config/alacritty/
	@rsync -av --delete ~/.config/mpd/       ./.config/mpd/
	@rsync -av --delete ~/.config/mpv/       ./.config/mpv/
	@rsync -av --delete ~/.config/ncmpcpp/   ./.config/ncmpcpp/
	@rsync -av --delete ~/.config/neofetch/  ./.config/neofetch/
	@rsync -av --delete ~/.config/osdlyrics/ ./.config/osdlyrics/
	@rsync -av --delete ~/.config/dunst/     ./.config/dunst/
	@rsync -av --delete ~/.config/zathura/   ./.config/zathura/
	@rsync -av --delete ~/.config/yazi/      ./.config/yazi/ --exclude 'plugins/'
	@rsync -av --delete ~/.config/aerc/      ./.config/aerc/
	@rsync -av --delete ~/.config/lazygit/   ./.config/lazygit/
	@rsync -av --delete ~/.config/newsboat/  ./.config/newsboat/
	@rsync -av --delete ~/.config/conky/     ./.config/conky/
	@rsync -av --delete ~/.config/easyeffects/input/  ./.config/easyeffects/input/
	@rsync -av --delete ~/.config/easyeffects/output/ ./.config/easyeffects/output/
	@rsync -av --delete ~/.config/rmpc/ 		 ./.config/rmpc/
	@mkdir -p ./.config/tmux
	@rsync -av ~/.config/tmux/tmux.conf ./.config/tmux/ --exclude 'plugins/'
	@crontab -l > crontab

install:
	# 同理，把 ./. 同步回 ~/
	@rsync -av --delete ./.bash_profile ~/.bash_profile
	@rsync -av --delete ./.zshrc ~/.zshrc
	@rsync -av --delete ./.zimrc ~/.zimrc
	@rsync -av --delete ./.config/ ~/.config/
	@(cat crontab) | crontab -
