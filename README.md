**i3-gaps and i3blocks config for archlinux on laptop**

how to :

1- install **ArchLinux** with xorg and configure your GPU with your favorite dm (or don't install dm and let script to install lightdm and enable it for you); 
	**if you already have ArchLinux and using it create a new user with `useradd -m -G wheel,users -s $(which bash) USERNAME` and login with it (because installer script doesn't create backup from local dotfiles)**

2- run `curl -s -o installer https://raw.githubusercontent.com/virtualdemon/i3-laptop-config/master/installer && chmod +x installer && ./installer`

3- install these packages from AUR with your installed aur helper (trizen installs by default):
 - i3lock-fancy-git (better than i3lock :P)
 - zsh-fast-syntax-highlighting-git (provide syntax highlighting for zshell) 
 - copyq (advanced clipboard manager)
 - cower-git (get informations from aur)
 - bibata-cursor-theme (cursor theme)
 - jcal-git (jalali calendar)
 - skippy-xd-git (a full-screen task-switcher )
 - ttf-emojione (to show emojies)
 - xkblayout-state-git (show keyboard language)
 - xfe (graphical file manager needed for udiskie)
 - uget-integrator-firefox (uget integrator for firefox)
 - otf-sanfrancisco-fonts (system font)

4- after installing AUR packages run this command to  remove orphan packages :  `sudo pacman -Rns $(pacman -Qqdt)`

5- enjoy !


# i3blocks

|Blocklets:|
|--|
|wrokspace buttons|
|memory usage|
|cpu usage|
|swap usage|
|filesystem usage|
|uptime|
|tor exit node|
|interface name (and wifi strength)|
|check internet connectivity|
|battery status|
|backlight percent|
|check updates|
|keyboard language|
|load average|
|output sound percent|
|pavucontrol|
|time (jalali calendar)|
|tray icons|  

# i3-gaps
| shortcut | action  |
|--|--|
| tap on touchpad | left click |
| double tap on touchpad | right click |
| triple tap on touchpad | middle click |
| XF86AudioRaiseVolume | raise output volume 5% | 
| XF86AudioLowerVolume | low output volume 5% |
| XF86AudioMute | mute output volume |
| XF86MonBrightnessUp | increase backlight +5 |
| XF86MonBrightnessDown | decrease backlight -5 | (first you should run `brightness` command to gain access for edit file)
| alt + tab | launch skippy-xd | 
| super + return | termite | 
| super + shift + return | tmux +  xterm | 
| super + d | dmenu |
| super + r | resize window |
| super + shift + r | restart i3 | 
| PrtSc | run flameshot |
| shift + PrtSc | take a full screen screenshot |
| super + shift + PrtSC | delay 5 second and take a full screen screenshot |
| ctrl + shift + PrtSC | dlay 5 second and run flameshot |
| super + shift + c | reload i3wm |
| super + shift + $NUMBER | move window(container) to workspace $NUMBER |
| super + $NUMBER | go to workspace $NUMBER |
| super + j,k,l,; | focus left,down,up,right |
| super + shift + j,k,l,; | move window (left,down,up,right) |
| super + a | focus parent window |
| super + shift + space | toggle floating |
| super + space | toggle focus |
| super + s | stacking layout |
| super + w | tabbed layout | 
| super + e | toggle split |
| super + f | toggle fullscreen |
| super + v | split in vertical orientation |
| super + h | split in horizontal orientation |
| super + shift + q | kill focused window |

| emacs like key bindings (Super=S) | action |
|--|--|
| S-x f | firefox |
| S-x v | vim |
| S-x t | telegram-desktop |
| S-x x | xfe |
| S-t s | start tor service|
| S-t r | restart tor service |
| S-t k | kill tor service |
| S-t l | tail -f /var/log/tor/log|
| S-shift-e l | lock |
| S-shift-e e | logout |
| S-shift-e h | hibernate |
| S-shift-e r | reboot |
| S-shift-e s | shutdown |
| S-shift-g o | configure outer gaps |
| S-shift-g i | configure inner gaps | 

# Scripts
| commands | action |
|--|--|
| appearance | change system customization |
| brightness | change backlight (add +$NUMBER or -$NUMBER to increase or decrease backlight) |
| cleancache | removes ram cache and ram pages and cleans swap |
| mirror-ranker | rank /etc/pacman.d/mirrorlist repositories |
| pm | a simple script to make pacman easier |
| transport_tor_proxy | route traffic trough tor with iptables | 
| cpuspeed | set "conservative,ondemand,performance" modes for cpu with cpupower |
| cpuspeed-freq | change cpu speed in "slow,fast" mode |
| aurbuild | install aur packages |
