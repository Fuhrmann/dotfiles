#!/bin/sh

border= \
center= \
class=$2 \
desktop= \
focus= \
follow= \
hidden= \
id=${1?} \
instance=$3 \
layer= \
locked= \
manage= \
marked= \
misc=$4 \
monitor= \
node= \
private= \
rectangle= \
split_dir= \
split_ratio= \
state= \
sticky= \
urgent=;

browser() {
	desktop=^2;
}

gimp() {
	follow=on;
}

spotify() {
	desktop=^7;
}

calculator() {
	rectangle='400x400+0+0';
	center=on;
	state=floating;
	layer=normal;
}

libreoffice() {
	state=tiled;
	layer=normal;
}

mpv() {
	state=floating;
	layer=normal;
}

pavucontrol() {
	rectangle='700x600+0+0';
	center=on;
	state=floating;
}

sublime() {
	desktop=^4;
}

htop() {
	state=floating;
	center=on;
	rectangle='750x600+0+0';
}

peek() {
	state=floating;
	center=on;
	rectangle='600x600+0+0';
}

wpg() {
	state=floating;
	center=on;
	rectangle='600x600+0+0';
}

chat() {
  desktop=^6;
}

phpstorm() {
	local name;

	read -r _ _ name <<-IN
		$(xprop -id "$id" _NET_WM_NAME)
	IN

	case $name in
		('"Project - '*'"')
			split_ratio=0.25;
			split_dir=west;;
		('"Structure - '*'"')
			split_ratio=0.75;
			split_dir=east;;
	esac;

	desktop=^3;
}

case $instance.$class in
  (*web.whatsapp.com*) chat;;
	(*.Spotify) spotify;;
	(*.[Gg]alculator) calculator;;
	(*.[Gg]oogle-chrome) browser;;
	(*.mpv) mpv;;
	([lL]ibre[oO]ffice*) libreoffice;;
	(*pavucontrol*) pavucontrol;;
	(*sublime_text*) sublime;;
	(jetbrains-phpstorm.jetbrains-phpstorm) phpstorm;;
	(htop.Alacritty) htop;;
	(*peek*) peek;;
	(*.[Ww]pg) wpg;;
	(.)
		case $(ps -p "$(xdo pid "$id")" -o comm= 2>/dev/null) in
			(spotify) spotify;;
		esac;;
esac;

echo \
	${border:+"border=$border"} \
	${center:+"center=$center"} \
	${desktop:+"desktop=$desktop"} \
	${focus:+"focus=$focus"} \
	${follow:+"follow=$follow"} \
	${hidden:+"hidden=$hidden"} \
	${layer:+"layer=$layer"} \
	${locked:+"locked=$locked"} \
	${manage:+"manage=$manage"} \
	${marked:+"marked=$marked"} \
	${monitor:+"monitor=$monitor"} \
	${node:+"node=$node"} \
	${private:+"private=$private"} \
	${rectangle:+"rectangle=$rectangle"} \
	${split_dir:+"split_dir=$split_dir"} \
	${split_ratio:+"split_ratio=$split_ratio"} \
	${state:+"state=$state"} \
	${sticky:+"sticky=$sticky"} \
	${urgent:+"urgent=$urgent"};

# vim: set ft=sh :
