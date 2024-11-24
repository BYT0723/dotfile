update:
	cp ~/.bash_profile          ./
	cp ~/.zshrc                 ./
	cp ~/.zimrc                 ./
	cp ~/.config/starship.toml  ./.config/
	cp ~/.config/screenkey.json ./.config/
	cp -r ~/.config/alacritty   ./.config/
	cp -r ~/.config/mpd         ./.config/
	cp -r ~/.config/mpv         ./.config/
	cp -r ~/.config/ncmpcpp     ./.config/
	cp -r ~/.config/neofetch    ./.config/
	cp -r ~/.config/osdlyrics   ./.config/
	cp -r ~/.config/dunst       ./.config/
	$(cp  ~/.config/ranger      ./.config)
	$(cp  ~/.config/tmux        ./.config)
	cp -r ~/.config/zathura     ./.config/
	cp -r ~/.config/yazi				./.config/
	cp -r ~/.config/aerc				./.config/
	cp -r ~/.config/lazygit			./.config/

install:
	cp ./.bash_profile ~/.bash_profile
	cp ./.zshrc        ~/.zshrc
	cp ./.zimrc        ~/.zimrc
	cp -r ./.config    ~/.config
