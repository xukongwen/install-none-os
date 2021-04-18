#/bin/bash

nmcli device wifi connect Pi password hotelvic

pacman -S zsh xorg qtile termite xorg-xinit feh emacs neofetch openssh

pacman -S fcitx5-chinese-addons fcitx5 fcitx5-gtk fcitx5-qt5 fcitx5-rime fcitx5-configtool-qt

#mv ./data/KKong3.ttf /etc/share/
# 启动x和qtile
touch /home/k/.zprofile
echo 'startx' > /home/k/.zprofile

touch /home/k/.xinitrc
echo 'exec qtile' > /home/k/.xinitrc

# 字体
sudo cp ./data/KKong3 /usr/share/fonts/
fc-cache -f -v

# 配置qtile和termit
cd
mkdir git
cd git
git clone https://github.com/xukongwen/.dotfiles.git

cp -r /home/install/data/wallpapers /home/k/

cd
mkdir .config
cp -r /home/k/git/.dotfiles/qtile/ /home/k/.config/
cp -r /home/k/git/.dotfiles/termite/ /home/k/.config/

# 配置中文
cp /home/k/git/.dotfiles/data/.pam_environment ~/

chsh -s /bin/zsh

zsh

reboot
