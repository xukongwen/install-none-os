#/bin/bash

#nmcli device wifi connect Pi password hotelvic

pacman -S zsh xorg qtile termite xorg-xinit feh emacs

pacman -S fcitx5-chinese-addons fcitx5 fcitx5-gtk fcitx5-qt5 fcitx5-rime fcitx5-configtool-qt

#mv ./data/KKong3.ttf /etc/share/

touch /home/k/.zprofile
echo 'startx' > /home/k/.zprofile

touch /home/k/.xinitrc
echo 'exec qtile' > /home/k/.xinitrc

sudo cp ./data/KKong3 /usr/share/fonts/
fc-cache -f -v

chsh -s /bin/zsh
