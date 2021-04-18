#/bin/bash

echo 'connect wifi'
sudo nmcli device wifi connect Pi password hotelvic

echo 'download pakages'
sudo pacman -S zsh xorg qtile termite xorg-xinit feh emacs neofetch openssh fcitx5-chinese-addons fcitx5 fcitx5-gtk fcitx5-rime fcitx5-configtool

echo 'enable ssh'
systemctl start sshd

#mv ./data/KKong3.ttf /etc/share/
# 启动x和qtile
touch /home/k/.zprofile
echo 'startx' > /home/k/.zprofile

touch /home/k/.xinitrc
echo 'exec qtile' > /home/k/.xinitrc

# 字体
echo 'make fonts'
sudo cp /home/install/data/KKong3 /usr/share/fonts/
fc-cache -f -v

# 配置qtile和termit
cd /home/k
mkdir git
cd git
echo 'clone git'
git clone https://github.com/xukongwen/.dotfiles.git

echo 'make wallpapers'
cp -r /home/install/data/wallpapers /home/k/

cd
mkdir .config
echo 'copy config'
cp -r /home/k/git/.dotfiles/qtile/ /home/k/.config/
cp -r /home/k/git/.dotfiles/termite/ /home/k/.config/

# 配置中文
echo 'config chinese'
cp /home/k/git/.dotfiles/data/.pam_environment ~/

echo 'turn zsh'
chsh -s /bin/zsh

echo 'run zsh'
zsh

reboot
