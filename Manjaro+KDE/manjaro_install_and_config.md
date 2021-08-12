# manjaro 安装配置

## 系统安装

### 镜像烧录

1. 在**manjaro**官网（或国内镜像站例如**清华tuna**）下载ISO镜像文件(推荐KDE版)，可选择最小化系统减少多余软件。

2. 通过镜像烧录软件：**balenaEtcher** 烧录进U盘

### 分盘安装

3. 提前将硬盘进行分区（留出空余空间即可不需建立分区）

4. 插入U盘开机选择U盘启动，进行manjaro安装，注意选择安装位置时不要覆盖其他系统。

---

## manjaro 配置

### 换源并更新系统

使用 `sudo pacman-mirrolist -i -c China` 即可获得全部中国镜像源并添加，`-m rank` 可以选择添加。

也可手动编辑 /etc/pacman.d/mirrorlist 写入:

> \## Country : China
> Server = http://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch

编辑`/etc/pacman.conf` 去掉`#Color`的注释可启用`pacman`颜色提示

通过`sudo pacman -Syu`更新系统

---

### yay - AUR工具

manjaro默认安装的base-devel不全，导致yay 装包时缺少打包工具，安装补全：`sudo pacman -S base-devel` 

然后`sudo pacman -S yay` 即可通过yay来安装AUR内软件

---

### zsh - shell

bash不好用,换zsh:`sudo pacman -S zsh` 

在 `/etc/hosts`中添加如下以解决github连接问题：

> \# For github
> 151.101.76.133	raw.githubusercontent.com
> 151.101.76.133	raw.github.com

**ip应根据当时实际查到为准（可在https://www.ip138.com/查询）**

[**on-my-zsh**](https://ohmyz.sh/):`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

重启生效默认终端（可手动使用`chsh -s /bin/zsh` 修改系统shell）

---

### 输入法 rime

`sudo pacman -S fcitx5-rime fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-material-color`

创建 `~/.xprofile` 添加如下：

> export GTK_IM_MODULE=fcitx5
> export QT_IM_MODULE=fcitx5
> export XMODIFIERS=@im=fcitx

修改配置文件：`~/.config/fcitx5/conf/classicui.conf`

> \#Theme
> Theme=Material-Color-Pink
> \# Font 
> Font="DejaVu Sans 13"
>
> \# 垂直候选列表
> #Vertical Candidate List=False
> \# 按屏幕 DPI 使用
> #PerScreenDPI=True

点击输入法图标添加rime输入法，在rime中按**F4**可选择简体输入法。

> `Theme`可选项有：
>
> - Material-Color-Pink
> - Material-Color-Blue
> - Material-Color-Brown
> - Material-Color-DeepPurple
> - Material-Color-Indigo
> - Material-Color-Red
> - Material-Color-Teal

输入方案配置目录为`.local/share/fcitx5/rime`

---

### archlinuxcn

`/etc/pacman.conf` 中添加：

> [archlinuxcn]
> Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
> Server = https://mirrors.cloud.tencent.com/archlinuxcn/$arch
> Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
> Server = https://mirrors.163.com/archlinux-cn/$arch

安装key:`sudo pacman -S archlinuxcn-keyring`

---

### cuda

`yay -S cuda cudnn`

---

## 桌面切换

建立两个虚拟桌面，两个活动(将切换快捷键设为super+alt+1和2)便于使用

### Virtual Desktops

KDE中一个Activity包含了自定义个virtual desktop，在使用`alt + tab`时，不在当前虚拟桌面中运行的程序不会显示和响应,也可以通过`ctrl + F10`查看当前Activity中的所有程序，同过`ctrl + F*` 可切换不同桌面

### Activities

KDE中的Activity是独立的桌面，不同活动之间可以配置不同的壁纸。可以通过`meta + tab`或自定义键切换。(可以将长期运行又不频繁交互的前台程序独立放到一个活动中，避免切换时的选择)

### Touchpad

通过[`libinput-gestures`](https://github.com/bulletmark/libinput-gestures)来使触摸板动作映射到键盘快捷键，关联桌面切换。

安装前置依赖`sudo pacman -S wmctrl xdotool`

安装libinput-gestures：`sudo pacman -S libinput-gestures`

命令行执行`sudo gpasswd -a $USER input`，把当前用户添加到input用户组解决无权限读取手势操作

`libinput-gestures-setup autostart`添加自启并启动`libinput-gestures-setup start`

`cp /etc/libinput-gestures.conf ~/.config/`并添加如下配置

> \# Switch to activity 1
> gesture swipe right 4 xdotool key super+alt+1
> \# Switch to activity 2
> gesture swipe left 4 xdotool key super+alt+2
>
> \# Switch to next desktop
> gesture swipe right 3 _internal ws_down
> \# Switch to prev desktop
> gesture swipe left 3 _internal ws_up
>
> \# Present windows (current desktop)
> gesture swipe up 3 xdotool key ctrl+F9
> \# Present windows (all desktop)
> gesture swipe up 4 xdotool key ctrl+F10
>
> \# hiden desktop
> gesture swipe down 3 xdotool key super+d
> \# Show desktops grid
> gesture swipe down 4 xdotool key ctrl+F8

也可根据文档配置成更复制的八向切换等

---

## 常用软件

### 网易云音乐

`yay netease-cloud-music`

### vscode

`yay visual-studio-code-bin`

### vim

`sudo pacman -S vim`

### typora

`yay typora`

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

## DRL配置

### pip 安装&换源

pip安装: `sudo pacman -S python-pip`

编辑 `~/.pip/pip.conf`:
> [global] 
> index-url = https://pypi.tuna.tsinghua.edu.cn/simple 

---

### python 3rd wheel

`pip3 install numpy  matplotlib  opencv-python`

---

### pythorch-cuda

`yay python-pycuda  python-pytorch-cuda  python-torchvision-cuda`  

直接使用yay安装简单快捷，pip安装可能会找不到cuda.h等问题

---

