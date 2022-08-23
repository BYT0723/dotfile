backup:
	cp ~/.profile ./profile
	cp ~/.bash_profile ./bash_profile
	cp ~/.tmux.conf ./tmux.conf
	cp ~/.tmux/* ./tmux
	cp ~/.config/ranger/rc.conf ./rc.conf


install:
	cp ~/profile ~/.profile
	cp ~/bash_profile ~/.bash_profile
	cp ~/tmux.conf ~/.tmux.conf
	cp -r ./tmux ~/.tmux
	cp ./rc.conf ~/.config/ranger/rc.conf
