#!/usr/bin/env bash
mkdir -p bin dotfiles/{dunst,gtk-3.0,irssi/scripts/autorun,skippy-xd,termite,trizen,youtube-viewer} etc/{tor,lightdm} fonts i3-config-files  screenshots themes

cp -rvf ~/bin/* ./bin/

cp -rvf ~/.config/dunst/* ./dotfiles/dunst/

cp -rvf ~/.config/gtk-3.0/* ./dotfiles/gtk-3.0/

cp -rvf ~/.config/skippy-xd/* ./dotfiles/skippy-xd/

cp -rvf ~/.config/termite/* ./dotfiles/termite/

cp -rvf ~/.config/trizen/* ./dotfiles/trizen

cp -rvf ~/.config/youtube-viewer/* ./dotfiles/youtube-viewer/

cp -fv ~/.config/compton.conf ./dotfiles/

cp -fv ~/.zshrc  ./dotfiles/zshrc
cp -fv ~/.profile ./dotfiles/profile
cp -fv ~/.gtkrc-2.0 ./dotfiles/gtkrc-2.0
cp -fv ~/.Xresources ./dotfiles/Xresources
cp -fv ~/.tmux.conf ./dotfiles/tmux.conf
cp -fv ~/.tmux.conf.local ./dotfiles/tmux.conf.local

cp -rfv ~/.irssi/* ./dotfiles/irssi/

cp -rfv ~/.fonts/* ./fonts/

cp -rfv /etc/tor/torrc ./etc/tor/

cp -rfv /etc/lightdm/lightdm-gtk-greeter.conf ./etc/lightdm/

cp -fv /etc/pacman.conf ./etc/pacman.conf

cp -fv /etc/locale.gen ./etc/locale.gen
cp -fv /etc/locale.conf ./etc/locale.conf



cp -rf ~/.config/i3/* ./i3-config-files/
