# arch linux + bspwm 

## pre-installation
### connect to wifi 
```sh
iwtcl 
```
### time update 
```sh
timedatectl set-ntp true 
timedatectl status  # check 
```
### partition the disks then format it
```sh
fdisk
mkfs.ext4 /dev/...
mkswap /dev/...
```
### mount the file system
```sh
mount /dev/... /mnt
mount /dev/... /mnt/boot/efi
swapon /dev...
```
---
## installation
### change mirrorlist
```sh
vim /etc/pacman.d/mirrorlist
Server = https://mirrors.163.com/archlinux/$repo/os/$arch
Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
```
### install essential packages
```sh
pacstrap /mnt base base-devel linux linux-firmware intel-ucode
```
---
## configure the system
### fstab
```sh
genfstab -U /mnt >> /mnt/etc/fstab
```
### chroot
```sh
arch-chroot /mnt
pacman -S vim # or nvim, there is no eiditer now
```
### time zone
```sh
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
```
### localization
```sh
vim /etc/locale.gen   # uncomment en_US.UTF-8 UTF-8  
locale-gen
vim /etc/locale.conf  # add LANG=en_US.UTF-8"
```
### network configuration
```sh
vim /etc/hostname # add myhostname
vim /etc/hosts
add follow:
      127.0.0.1	localhost                            
      ::1		localhost
      127.0.1.1	micasa-arch.localdomain micasa-arch
```
### root password
```sh
passwd
```
### bootloader
```sh
pacman -S grub os-prober efibootmgr dosfstools ntfs-3g
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Archlinux
grub-mkconfig -o /boot/grub/grub.cfg
```
---
## after installation
### add user
```sh
visudo # uncomment %wheel
       # or vim /etc/sudoers
useradd -m -g wheel micasa
passwd micasa
```
### pacman configuration
```sh
vim /etc/pacman.conf
# uncomment Color, [multilib]
# add:
# [archlinuxcn]
# Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$arch
sudo pacman -S archlinux-keyring
```

---

### 常用软件

> ### zsh
> ```sh
> yay oh-my-zsh
> cp /usr/share/oh-my-zsh/zshrc .zshrc
> chsh -s /bin/zsh 
> ```
> ### internet tool
> ```sh
> pacman -S dhcpcd networkmanager iwd  # or iwd maybe batter
> ```
> ### brightness control
> ```sh
> pacman -S acpilight  # or xorg-xbacklight    acpilight works on mycomputer 
> sudo usermod -aG video micasa # chage /sys/class/backlight/.../brightness without sudo 
> ```
> ### volume control
> ```sh
> pacman -S alsa-utils
> # alsamixer 中 master 是全局音量  headphon是耳机  speark扬声器   MM代表静音 00使能
> ```
> ### bluetooth&headphone
> ```sh
> pacman -S blueberry pulseaudio-bluetooth
> ```
> ### ~~nm-applet~~
> ```sh
> pacman -S network-manager-applet
> ```
> ### graphical service
> ```sh
> pacman -S xorg xorg-xinit
> ```
> ### window manager
> ```sh
> pacman -S bspwm sxhcd
> pacamn -S wmname # fix java problem
> ```
> ### ~~lightdm~~
> ```sh
> pacman -S lightdm lightdm-gtk-greeter
> ```
> ### status bar 
> ```sh
> pacman -S polybar
> ```
> ### screen lock
> ```sh
> pacman -S betterlockscreen
> ```
> ### terminal
> ```sh
> pacman -S alacritty
> ```
> ### launcher
> ```sh
> pacman -S rofi
> ```
> ### fonts
> ```sh
> pacman -S noto-fonts-cjk noto-fonts-emoji wqy-zenhei wqy-microhei
> ```
> ### input method
> ```sh
> pacman -S fcitx5-rime fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-material-color
> ```
> ### files manager
> ```sh
> pacman -S nemo
> ```
> ### browser
> ```sh
> pacman -S firefox
> ```
> ### image view
> ```sh
> pacman -S feh
> ```
> ### markdowm editor
> ```sh
> pacman -S typora
> ```
> ### picom
> ```sh
> pacman -S picom
> ```
> ### music
> ```sh
> pacman -S electron-netease-cloud-music # replace for netease-cloud-music, login with netease account, support chinese input
> ```
> ### screnshot
> ```sh
> pacman -S flameshot
> ```
> ### kdeconnect
> ```sh
> pacman -S kdeconnect
> ```
> ### wps office
> ```sh
> yay -S wps-office-cn ttf-wps-fonts wps-office-mui-zh-cn
> # ttf-wps-fonts 中文字体 wps-office-mui-zh-cn 修改界面语言中文
> ```
> ### mindmaster 
> ```sh
> yay -S mindmaster_cn
> ```
> ### image editer 
> ```sh
> pacman -S gimp
> ```
> ### video player 
> ```sh
> pacman -S vlc
> ```
> ### video editer 
> ```sh
> pacman -S openshot
> ```
> ### video recoder&stream 
> ```sh
> pacman -S obs-studio
> ```
> ### 3D graphics creation
> ```sh
> pacman -S belender
> ```
> ### Flash OS images
> ```sh
> #yay -S balena-etcher
> #there is appimage in https://www.balena.io/etcher/ . maybe better
> ```
> ### game
> ```sh
> pacman -S steam ttf-liberation # ttf字体 似乎也需要wqy-zenhei wqy-microhei
> ```
> ### nvidia driver
> ```sh
> pacman -S nvidia
> ```
> ### CUDA
> ```sh
> pacman -S cuda
> ```

---

### 常用软件配置文件

configuration：
	bspwm窗体  sxhcd热键  polybar样式  设备驱动 等.

---
## 开机设置
### 修改grub时间为0
```sh
vim /etc/default/grub
GRUB_TIMEOUT=0
```

### 自动登录
```sh
vim /etc/systemd/system/getty.target.wants/getty@tty1.service
add:
ExecStart=-/usr/bin/agetty --autologin micasa --noclear %I $TERM
```

### startx自启动
```sh
cp /etc/zsh/zprofile ~/.zprofile
add:
mulate sh -c 'source /etc/profile'
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
```

---

## Github ssh

### 创建ssh key

1. 设置git的user name和email

   ```sh
   git config --global user.name "micasa-git"
   git config --global user.email "micasa-d@outlook.com"
   ```

2. 生成 ssh key 

   ```sh
   ssh-keygen -t rsa -C "micasa-d@outlook.com"		#选择默认位置生产，默认空密码即可
   ```

3. 获取 ssh key

   ```sh
   cd ~/.ssh
   cat id_rsa.pub	#拷贝内容
   ```

### github 添加 ssh key
4. 在github -> setting -> SSH and GPG keys 中 添加ssh key 填入key 并取title名

5. 验证 

   ```sh
   ssh -T git@github.com
   #出现以下字样则成功:
   Hi micasa-git! You've successfully authenticated, but GitHub does not provide shell access.
   ```

---

### pip 安装&换源

pip安装: `sudo pacman -S python-pip`
编辑 `~/.pip/pip.conf`:

```sh
[global] 
ndex-url = https://pypi.tuna.tsinghua.edu.cn/simple 
```

---

### 输入法配置

修改配置文件：`~/.config/fcitx5/conf/classicui.conf`

```sh
#Theme
Theme=Material-Color-Pink # Blue Brown DeepPurple Indigo Red Teal
# Font 
Font="DejaVu Sans 13"

# 垂直候选列表
#Vertical Candidate List=False
# 按屏幕 DPI 使用
#PerScreenDPI=True
```

点击输入法图标添加rime输入法，在rime中按**F4**可选择简体输入法。
输入方案配置目录为`.local/share/fcitx5/rime`

---
### 参考
[arch wiki](https://wiki.archlinux.org/)
[arch wiki Installation guide](https://wiki.archlinux.org/title/Installation_guide)
[arch wiki bspwm](https://wiki.archlinux.org/title/Bspwm)
[bspwm](https://github.com/baskerville/bspwm)
[polybar-themes](https://github.com/adi1090x/polybar-themes)
[polybar-scripts](https://github.com/polybar/polybar-scripts)

---

## TODO
sxhkd  键位长期磨合更新
bspwmrc  在多显示器前应该不会更新
polybar theme 短期不变，精简
polybar script 慢慢探索，但简洁为主
dpi问题2k屏软件显示太小
