#!/bin/sh -l

if [ -d "/github" ];then
    sudo chown -R build /github/workspace /github/home
fi
sudo pacman -Sy 

sudo pacman-key --init
sudo pacman-key --populate archlinux
wget https://raw.githubusercontent.com/atolycs/ardentlinux-keyring/master/ardentlinux.gpg
sudo pacman-key --add ./ardentlinux.gpg
gpg --import ./ardentlinux.gpg

ls -lsa

ls -1 *.pkg.tar.zst | while read line; do
    gpg --output "${line}.sig" --detach-sig "${line}"
done

repo-add -n --sign ardent-staging.db.tar.xz *.pkg.tar.zst
repo-add -n --sign ardent-stable.db.tar.xz *.pkg.tar.zst


echo "================"
echo "Package created:"
#echo `ls -lsa`
ls -lsa
echo "================"
