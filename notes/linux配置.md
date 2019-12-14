# Arch
- 判断是uefi还是bios

  ```shell
  # 如果目录不存在，则是bios。
  ls /sys/firmware/efi/efivars。
  ```
  
- 分区

  ```shell
  # 查看磁盘情况 
  fdisk -l
  # 分四个区，依次为 EFI、root、home、swap
  cfdisk /dev/**
  ```

- 格式化分区

  ```shell
  # 查看分区情况 
  fdisk -l
  mkfs.fat -F32 /dev/**
  # 设置分区的标签为 root，不然要用 UUID 引用分区
  mkfs.ext4 -L root /dev/**
  # 设置交换分区
  mkswap /dev/**
  swapon /dev/**
  ```

- 挂载分区
  root 挂载到 /mnt；在 mnt 创建相应文件夹，然后将 efi 挂载到 /mnt/boot/EFI，home 挂载到 /mnt/home
  
- 连接网络

  ```shell
  # 连接有线网络
  dhcpd
  # 连接热点
  NetworkManager 用于管理 wifi 连接，和 iw 同类
  nmcli dev wifi list
  nmcli dev wifi connect <SSID> password <password> [hidden yes]
  nmcli connection delete CONNECTION_NAME # 上面连接失败后，以后的连接仍然用错误凭证，所以先删除
  # 或者
  wifi-menu
  ```
  
- 更新时间

  在联网时，及安装时验证证书有效

  ```shell
  timedatectl set-ntp true
  ```

- 配置 pacman 镜像源
  
  将：https://mirrors.huaweicloud.com/archlinux/
  
  和 tuna
  
  放到 /etc/pacman.d/mirrorlist 的前面
  
- 安装基础包

  ```shell
  pacstrap /mnt base linux linux-firmware networkmanager sudo ntfs-3g dnsmasq
  # ntfs-3g os-prober 和 dolphin 需要
  # dnsmasq 在创建热点时用于作 dns 服务器
  ```

- 生成分区表

  ```shell
  genfstab -U /mnt>>/mnt/etc/fstab
  # 然后查看fstab，看是否有四个分区
  ```

- 切入 /mnt 中

  相比`chroot`，`arch-chroot`可以自行挂载 /run

  ```shell
  arch-chroot /mnt
  ```
  
- 设置主机名
  ```shell
  echo ** > /etc/hostname
  ```
  
- 设置root的密码
  ```shell
  passwd
  ```
  
- 设置时区

  ```shell
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
  # 设置硬件时间
  hwclock --systohc
  ```

- 本地化设置

  ```shell
  # 1. 
  将/etc/locale.gen中的
  en_US.UTF-8
  zh_CN.UTF-8
  zh_HK.UTF-8
  注释去掉
  # 2.生成 locale
  locale-gen
  # 3.设置默认 locale，UI、命令行尽量用英文
  echo 'LANG=en_US.UTF-8' >/etc/locale.conf
  ```

- 设置hosts文件
	
	```
	127.0.0.1	localhost
	::1		localhost
	127.0.1.1	myhostname.localdomain	myhostname
	```

- 安装引导程序

  ```shell
  pacman -S grub efibootmgr os-prober
  grub-install --target=x86_64-efi --efi-directory=<EFI 分区挂载点> --bootloader-id=<启动项在 BIOS 中的名字>
  grub-mkconfig -o /boot/grub/grub.cfg
  ```

- 退出安装

  ```shell
  # 1.
  exit
  # 2.
  umount -R /mnt
  # 3.
  reboot
  # 4.移除安装介质
  ```

- 添加新用户

  ```shell
  useradd -m -G wheel -s /bin/bash fwinac
  # -m 创建相应 home 目录
  passwd fwinac
  ```

- 设置新用户可 sudo  
  在 /etc/sudoers 中 fwinac 后添加和 root 后一样的内容

  或：
  
  将 /etc/sudoers 中 %wheel 前的注释去掉
  
- 屏蔽 nouveau，安装 bbswitch
  在 /etc/modprobe.d/nouveau_blacklist.conf 添加 blacklist nouveau

- 安装dde

  1. 安装 deepin
  1. 在 /etc/lightdm/lightdm.conf设置
     [Seat:*]
     greeter-session=lightdm-deepin-greeter

- 设置 DE 程序开机启动

  1. systemctl enable lightdm/sddm
  1. systemclt enable NetworkManager
  1. systemctl enable bluetooth

- 安装字体
  
  noto，no tofu
  
  noto-fonts noto-fonts-cjk noto-fonts-emoji

- 添加 archlinuxcn 源

  1. 在 `/etc/pacman.conf` 文件末尾添加：

     ```
     [archlinuxcn]
     Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
     ```
     
  2. 安装密钥

     ```shell
     $ sudo pacman -S archlinuxcn-keyring
     ```

- 安装输入法
	1. 安装 fcitx-im fcitx-configtool/kcm-fcitx
	
	2. vim ~/.xprofile(xprofile 适用 xorg，也可添加到 ~/.pam_environment，不用加 export) 
	
	   ```shell
	   export GTK_IM_MODULE=fcitx
	   export QT_IM_MODULE=fcitx
	   export XMODIFIERS="@im=fcitx"
	   ```

`参考`
- [中文动图安装参考](https://bbs.archlinuxcn.org/viewtopic.php?id=1037)

- 将主目录里面的文件夹汉字转英文

  ```shell
  $ sudo pacman -S xdg-user-dirs-gtk
  $ export LANG=en_US
  $ xdg-user-dirs-gtk-update
  # 然后会有个窗口提示语言更改，更新名称即可
  $ export LANG=zh_CN.UTF-8
  # 然后重启电脑，如果提示语言更改，保留旧的名称即可
  ```

# i3wm

- 设置缩放
  修改主目录下的 .Xresources 文件，把 Xft.dpi 改为 125
  
- 设置主题
  修改 lxapperance 和 qt5ct 中的 style，选择亮色主题。
- 安装 shadowsocks-qt5 alacritty polybar vim-plug nitrogen 

- 复制 github 相关配置文件到系统中

- 重启

- 添加代理
  安装 proxychains 和 privoxy，设置 http porxy。
  
- 用 proxychains 启动 chrome(脚本)，然后同步

- 安装 zsh

- 配置 conky 字体

`参考`

  - 脚本在 refs 目录下的 pchrome.sh


# 编译内核

debian、build-essential、kernel-package（打包deb）、libncurses5-dev（new curses在terminal中实现图形界面）、fakeroot、libssl-dev、flex、bison

```shell
make mrproper #清理 source tree，使其回复到刚解压的状态
```

```shell
patch -p1 <  *.patch #打补丁
```

```shell
cp /boot/config-`uname -r`* .config　#将现有配置文件拷贝到.config文件夹
# 为什么要make，因为新的内核可能会增加新的配置项，所以.config还不能直接用
make olddefconfig #依据配置文件配置新内核，新设置用推荐值
```
OR
```shell
make localmodconfig #根据当前使用情况载入配置
```

```shell
make menuconfig #打开terminal gui，手动定制
```

```shell
make -j8 deb-pkg #编译并打包，会生成 header、lib、image、dbg，dbg 不用安装
```

```shell
sudo apt install linux-*.deb
```

```shell
sudo apt purge remove linux-image/headers-
```

# 内核模块

- 分类

  built-in or loadable(M)，loadable 可以运行时随意进出内核，而不需要重启。

- DKMS

  当内核变化时，包管理器的 hook 就会自动编译模块。这样，如果内核 ABI 变动，模块就不必紧贴内核更新，重新编译并发布新的二进制文件。

- 使用

  debian 系在 blacklist 内核模块后需要 `sudo update-initramfs -u`


# 安装后比做

- 音频
  1. 安装 pulseaduio
  2. 安装 pulseaduio-alsa
  
- 省电

  1. 关闭 watchdog(Archwiki#Improving performance)
  2. 安装 tlp，并根据 tlp-stat 配置

- 关闭 audit log

  在 boot parameter 中添加 audit=0

- 安装 lts

  linux-lts linux-lts-headers，以后安装软件使用 dkms 包

  安装后重新生成 grub config

- 安装 intel-code

  安装后重新生成 grub config

# 发行版及桌面对比

## Windows

- 软件体系冗余

  Windows 软件和 Linux 软件都在，但融合程度较低，无法相互调用。

- 命令行功能弱

- 对用户隐藏细节

  当系统出现某些奇怪的毛病的时候，系统日志隐藏了太多细节。用户往往没有办法发现问题，也没有渠道自己解决问题。

## deepin

- Windows 原生的软件大部分不能在 deepin 很好的运行
- deepin 系统软件本身质量还不够高，会有许多小问题
- 软件仓库太老，更新周期也跟不上“上游”

## Fyde OS

“中国版” Chrome OS

- 缩放不好

- 硬件支持不好

  如显卡

- 不能使用 VirtualBox

- 不带 Google 账号同步


## Fedora 和 Arch 

- DDE 主要是在 deepin 上开发的，所以，除 deepin 外都会遇到小问题。
- 程序比较新，且程序对 Arch、Fedora 适配不太好：比如 Android Studio 主要在 ubuntu 下开发，导致教程中的配置方式在 Arch 不适用。

## 国外发行版

- flatpak、Snap 在中国下载速度很慢
- 常用应用的 wine 麻烦：即使 wine 出来也比 deepin 的差太多：字体模糊，小问题等等。
## Gnome
- 显示效果不好，缩放后显得很大

## KDE

- 对 wine 的支持不太好
