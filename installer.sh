#!/usr/bin/env bash

#Define {file,script,package} names
MAIN_PACKAGES=(i3-gaps i3blocks dmenu dunst gtk-engine-murrine xorg-xdpyinfo xorg-xprop fzf dialog cpupower pacman-contrib gst-libav gst-plugins-bad gst-plugins-good gst-plugins-ugly gst-plugins-base gst-plugins-base-libs gstreamer  numix-gtk-theme termite tmux xterm flameshot udiskie xorg-xinput libinput xf86-input-libinput compton xorg-setxkbmap bc sysstat gnu-netcat feh acpi networkmanager neofetch  network-manager-applet pavucontrol zsh git grml-zsh-config zsh-completions ttf-dejavu ttf-font-awesome ttf-freefont ttf-hack ttf-roboto ttf-ubuntu-font-family awesome-terminal-fonts otf-font-awesome base-devel qca-qt5 qt5-base qt5-declarative qt5-imageformats qt5-location qt5-script qt5-sensors qt5-svg qt5-tools qt5-webchannel qt5-webkit qt5-x11extras qt5-xmlpatterns)

OPTIONAL_PACKAGES=(telegram-desktop
		libreoffice-fresh-fa
		htop
		irssi
		perl-glib-object-introspection
		perl-crypt-blowfish
		perl-crypt-cbc
		irssi-otr
		mlocate
		aria2
		ntfs-3g
		dkms
		linux-headers
		unrar
		p7zip
		mupdf
		mesa
		alsa-plugins
		alsa-utils
		alsa-oss
		pulseaudio
		ranger
		mpv
		gnome-keyring
		openvpn
		networkmanager-openvpn
		elinks
		wgetpaste
		firefox
		firefox-adblock-plus
		uget
		pkgfile
		arduino)

BLOCKLETS=(brightness
	background-setter
	backlight
	band-width
	checkupdates
	connection
	cpu-usage
	filesystem-usage
	jalali-calendar
	keyboard-layout
	mem-usage
	swap-usage
	tor-country
	uptime
	volume-icons
	wireless-or-cable)

BIN_SCRIPTS=(appearance
	brightness
	cleancache
    mirror-ranker
   	pm
   	transparent_tor_proxy
	cpuspeed
	cpuspeed-freq
	aurbuild
	dialog-sudo
	background-setter)

I3_CONFIGS=(config
	    i3blocks.conf)

DOTFILES=(termite/config
	dunst/dunstrc
	skippy-xd/skippy-xd.rc
	compton.conf
	gtk-3.0/settings.ini
	trizen/trizen.conf)

HOME_DOTFILES=(Xresources
		gtkrc-2.0
		profile
		zshrc
		youtube-viewer/youtube-viewer.conf
		irssi/blowjob.conf
		irssi/config
		irssi/h3rbz.theme
		irssi/startup
		irssi/scripts/autorun/blowjob.pl
		irssi/scripts/autorun/desktop-notify.pl
		irssi/scripts/autorun/smartfilter.pl)

FONTS=(Aldrich-Regular.ttf
	SanFranciscoText-Regular.otf
	brightontwo-sans-nbp.ttf)

#Ask to add pacman.conf
clear
read -p "Do you want to add pacman.conf (contains archlinuxcn repository) ?[y/N] " PACMANCONF_ADD_ANS
if [ "$PACMANCONF_ADD_ANS" == "y" ] || [ "$PACMANCONF_ADD_ANS" == "Y" ]; then
	ech "Adding to /etc/pacman.conf"
	sudo mv /etc/pacman.conf /etc/pacman.conf-ORIG
	sudo curl -s -o /etc/pacman.conf https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/etc/pacman.conf
	sudo pacman -Syu archlinuxcn-keyring xdelta3
	sudo pacman-key --populate archlinuxcn
fi

#Install needed packages for this config
clear
echo "installing Main packages..."
sleep 3
sudo pacman -S ${MAIN_PACKAGES[@]} --noconfirm --needed

#Install tor and obfs4proxy
clear
read -p "do you want to install tor? [y/N] " INST_TOR
if [ "$INST_TOR" == "y" ] || [ "$INST_TOR" == "Y" ];then
	sudo pacman -S tor torsocks whois --noconfirm --needed --force
	echo "installing obfs4proxy form archlinuxcn"
	OBFSPROXY_PACKAGE=$(curl  http://repo.archlinuxcn.org/x86_64/ |sed 's/<\/\?[^>]\+>//g'| grep obfs4proxy | awk '{ print $1 }' | head -1)
	if [ -e $(which wget) ];then
		wget http://repo.archlinuxcn.org/x86_64/$OBFSPROXY_PACKAGE
	else
	        curl -s -o $OBFSPROXY_PACKAGE http://repo.archlinuxcn.org/x86_64/$OBFSPROXY_PACKAGE
	fi
	sudo pacman -U obfs4proxy*.tar.xz --needed --noconfirm
	echo "downloading torrc"
	sudo mv /etc/tor/torrc /etc/tor/torrc-ORIG
	sudo curl -s -o /etc/tor/torrc https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/etc/tor/torrc
	echo "making log file and changing permissions"
	sudo mkdir /var/log/tor
	sudo touch /var/log/tor/log
	sudo chown -R tor:tor /var/log/tor
	echo "enabling tor.service"
	sudo systemctl start tor.service
	sudo systemctl enable tor.service
	echo "to check tor situation : tail -f /var/log/tor/log"
	sleep 5
	else
 		echo "tor didn't installed..."
		sleep 3
fi

#Ask to install lightdm
clear
read -p "Do you want to install LightDM (a light weight display manager)? [y/N] " LIGHTDM_INST_ANS
	if [ "$LIGHTDM_INST_ANS" == "y" ] ||  [ "$LIGHTDM_INST_ANS" == "Y" ]; then
		sudo pacman -S lightdm lightdm-gtk-greeter --noconfirm --needed --force
		sudo systemctl disable display-manager.service
		sudo systemctl enable lightdm.service
	fi

#Add lightdm-gtk-greeter config if exist
if [ ! -z $(pacman -Qq lightdm-gtk-greeter) ];then
	sudo curl -s -o /etc/lightdm/lightdm-gtk-greeter.conf https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/etc/lightdm/lightdm-gtk-greeter.conf
	sudo mkdir -p /usr/share/lightdm-background
	sudo curl -s -o /usr/share/lightdm-background/08303b0034dec9b5a48e98c305464edd.JPEG https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/backgrounds/08303b0034dec9b5a48e98c305464edd.JPEG
fi

#Enable NetworkManager service
clear
sudo systemctl disable dhcpcd.service
sudo systemctl enable NetworkManager.service

#Install optional packages for daily usage
clear
for PACKAGE in ${OPTIONAL_PACKAGES[@]} ; do
	read -p "Do you want to install $PACKAGE ? [y/N] " INST_OPT_PACKAGE
		case $INST_OPT_PACKAGE in
		"Y"|"y")
		FILTERED_OPTIONAL_PACKAGES+=($PACKAGE)
		;;
		esac
		read -p "Do you want add packages manually? [y/N] " ADD_PACKAGES_MANUALLY
		case $ADD_PACKAGES_MANUALLY in
		"Y"|"y")
		read -p "Please add your packages in one line including space between packages!(make sure package exist i dont handle this thing!) : " MANUALLY_ADDED_PACKAGES
		FILTERED_OPTIONAL_PACKAGES=(MANUALLY_ADDED_PACKAGES)
		echo "The ${FILTERED_OPTIONAL_PACKAGES[@]} are going to be installed!"
		sudo pacman -S ${FILTERED_OPTIONAL_PACKAGES} --noconfirm --needed --force
		sleep 2
		clear
	else
		clear
	fi
done

#Update pkgfile databases
clear
if [ -e $(which pkgfile) ];then
	read -p "Do you want to run : pkgfile --update ? [y/N] " PKGFILE_ANS
	if [ "$PKGFILE_ANS" == "y" ] || [ "$PKGFILE_ANS" == "Y" ];then
		sudo pkgfile --update
	fi
fi

#Create needed directories
clear
echo "creating directories"
sleep 3
cd && mkdir -p systemScreenshots bin .irssi/scripts/autorun .config/{gtk-3.0,termite,skippy-xd,i3/blocklets,dunst,trizen} .fonts

#Ask for aur helper (by default it's trizen)
clear
read -p "Do you want install trizen ? (a nice and fancy aur helper) [y/N] " TRIZEN_INSTALL_ANS
if [ "$TRIZEN_INSTALL_ANS" == "y" ] ||  [ "$TRIZEN_INSTALL_ANS" == "Y" ] ;then
	clear
	cd Github && git clone https://aur.archlinux.org/trizen-git.git
	cd trizen-git
	makepkg -sri --noconfirm
	cd
fi

#Download configs and scripts
clear
for BLOCKLET in ${BLOCKLETS[@]} ;do
	echo "Adding $BLOCKLET"
	curl -s -o $HOME/.config/i3/blocklets/$BLOCKLET https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/i3-config-files/blocklets/$BLOCKLET
done

#Make i3blocks blocklets executable
chmod +x $HOME/.config/i3/blocklets/*

clear
for BIN_SCRIPT in ${BIN_SCRIPTS[@]}; do
	echo "Adding $BIN_SCRIPT"
	curl -s -o $HOME/bin/$BIN_SCRIPT https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/bin/$BIN_SCRIPT
done

#Make ~/Bin scripts executable
chmod +x $HOME/bin/*

clear
for I3_CONFIG in ${I3_CONFIGS[@]};do
	echo "Adding $I3_CONFIG"
	curl -s -o $HOME/.config/i3/$I3_CONFIG https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/i3-config-files/$I3_CONFIG
done

clear
for HOME_DOTFILE in ${HOME_DOTFILES[@]};do
	echo "Adding $HOME_DOTFILE"
	curl -s -o $HOME/.$HOME_DOTFILE https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/dotfiles/$HOME_DOTFILE
done

clear
for DOTFILE in ${DOTFILES[@]}; do
	echo "Adding $DOTFILE"
	curl -s -o $HOME/.config/$DOTFILE https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/dotfiles/$DOTFILE
done

for FONT in ${FONTS[@]}; do
	echo "Adding $FONT"
	curl -s -o $HOME/.fonts/$FONT https://gitlab.com/virtualdemon/archlinux-configuration/raw/master/fonts/$FONT
done

#Load xresources file
xrdb -load $HOME/.Xresources

#Update font cache
fc-cache -fv
sudo fc-cache -fv

#Configure touchpad in config
DEVICE=$(xinput list | grep Touchpad | awk '{print $3" "$4" "$5}')
sed -i "s/FTE1200:00 0B05:0201 Touchpad/$DEVICE/g" $HOME/.config/i3/config

#Restart i3
if [ ! -z "$(ps aux | grep i3 | grep "i3$")" ] ;then
       	i3-msg restart
fi
