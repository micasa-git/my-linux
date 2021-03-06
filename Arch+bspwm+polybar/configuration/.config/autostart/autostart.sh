#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}



feh --bg-fill $HOME/Pictures/entity-3840x2160.png &
betterlockscreen -w blur
source ~/.fehbg

betterlockscreen -l blur

#numlockx on &
run fcitx5 &
kdeconnect-indicator &
blueberry-tray &
picom --config $HOME/.config/autostart/picom.conf &
$HOME/.config/polybar/launch.sh --shapes &


#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal

#$HOME/.config/polybar/launch.sh --shapes &

#change your keyboard if you need it
#setxkbmap -layout be

#Some ways to set your wallpaper besides variety or nitrogen
#feh --bg-scale ~/.config/bspwm/wall.png &
#feh --bg-fill $HOME/Pictures/entity-3840x2160.png &
#feh --randomize --bg-fill ~/Képek/*
#feh --randomize --bg-fill ~/Dropbox/Apps/Desktoppr/*

#betterlockscreen -w blur
#source ~/.fehbg

#dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
#xsetroot -cursor_name left_ptr &
#run sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &

#conky -c $HOME/.config/bspwm/system-overview &
#run variety &
#run nm-applet &
#run fcitx5 &
#run xfce4-power-manager &
#numlockx on &
#blueberry-tray &
#picom --config $HOME/.config/autostart/picom.conf &
#betterlockscreen -l blur
#kdeconnect-indicator &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &
#run volumeicon &
#nitrogen --restore &
#run caffeine &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
#run insync start &
#run discord &
#run spotify &
#run atom &
