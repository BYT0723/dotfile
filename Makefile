update:
	cp ~/.bash_profile            ./
	cp ~/.zshrc                   ./
	cp ~/.p10k.zsh                ./
	cp ~/.zimrc                   ./
	cp -r ~/.zim                  ./
	cp -r ~/.config/mpd           ./.config/
	cp -r ~/.config/mpv           ./.config/
	cp -r ~/.config/ncmpcpp       ./.config/
	cp -r ~/.config/neofetch      ./.config/
	cp -r ~/.config/nnn           ./.config/
	cp -r ~/.config/osdlyrics     ./.config/
	cp -r ~/.config/tmux          ./.config/
	cp -r ~/.config/ranger        ./.config/
	cp ~/.config/screenkey.json   ./.config/

install:
	cp ./.bash_profile 						~/.bash_profile
	cp ./.zshrc 									~/.zshrc
	cp ./.p10k.zsh 								~/.p10k.zsh
	cp ./.zimrc 									~/.zimrc
	cp -r ./.config 							~/.config
