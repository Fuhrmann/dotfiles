[global/wm]
;https://github.com/jaagr/polybar/wiki/Configuration#global-wm-settings
margin-top = 0
margin-bottom = 0

[settings]
throttle-output = 5
throttle-output-for = 10
throttle-input-for = 30
screenchange-reload = true
compositing-background = over
compositing-foreground = over
compositing-overline = over
compositing-underline = over
compositing-border = over

[colors]
background = #101916
foreground = #78B183
foreground-inactive = #4E734F
separator = #78B183
workspace-background = #233730
alert = #4E734F
transparent = #00000000

[sizes]
bar_width = 100%
bar_height = 35

[bar/main]
monitor = ${env:MONITOR:HDMI-0}
background = ${colors.background}
foreground = ${colors.foreground}
wm-restack = i3
bottom = true
fixed-center = false
cursor-click = pointer
monitor-strict = false
override-redirect = false
locale = pt_BR.UTF-8
width = ${sizes.bar_width}
height = ${sizes.bar_height}
padding-left = 0
padding-right = 1
scroll-up = i3wm-wsnext
scroll-down = i3-wsprev
tray-position = none
tray-scale = 1.0
tray-maxsize = 16
tray-padding = 0
module-margin-left = 1
module-margin-right = 1
separator =
line-size = 4
border-size = 0

font-0 = "mononoki:size=11;4"
font-1 = "Font Awesome 5 Pro:style=Regular:size=10;3"
font-2 = "Font Awesome 5 Pro:style=Solid:size=10;4"
font-3 = "Font Awesome 5 Brands Regular:style=Regular:size=10;4"

modules-left = i3 
modules-center = 
modules-right = playing fs_home fs_movies trash pulseaudio date

[bar/second]
inherit = bar/main
monitor = ${env:MONITOR:DP-5}
modules-left = i3
modules-center =
modules-right =

[module/i3]
type = internal/i3
pin-workspaces = true
index-sort = true
enable-click = true
wrapping-scroll = false
reverse-scroll = false
format = <label-state> <label-mode>
strip-wsnumbers = false
fuzzy-match = true

label-mode-padding = 2
label-mode-background = ${colors.workspace-background}

label-focused = %index%
label-focused-padding = 1
label-focused-background = ${colors.workspace-background}
label-focused-underline = ${colors.foreground-inactive}

label-unfocused = %index%
label-unfocused-padding = 1
label-unfocused-foreground = ${colors.foreground-inactive}

label-visible = %index%
label-visible-padding = 1
label-visible-background = ${colors.workspace-background}

label-urgent = %index%
label-urgent-padding = 1

ws-icon-0 = term;
ws-icon-1 = browse;
ws-icon-2 = code;
ws-icon-3 = game;
ws-icon-4 = chat;
ws-icon-5 = music;
ws-icon-6 = warez;
ws-icon-default = 

[module/separator]
type = custom/text
content =|
content-foreground = ${colors.separator}
content-padding = 0

[module/playing]
type = custom/script
exec = playercontrol
tail = true

[module/transmission]
type = custom/script
exec = torrentstatus
interval = 30

[module/cpu]
type = internal/cpu
interval = 0.5
format = <label>
label =  cpu %percentage%%
label-font = 0

[module/fs_abstract]
type = internal/fs
interval = 25
format-mounted = <label-mounted>
label-unmounted = %mountpoint% not mounted
label-unmounted-foreground = ${colors.foreground-inactive}

[module/fs_movies]
inherit = module/fs_abstract
mount-0 = /disks/Filmes
label-mounted = %{B#233730} %{F#4E734F}%{F-} %{B-} %percentage_used%%

[module/fs_home]
inherit = module/fs_abstract
mount-0 = /home
label-mounted = %{B#233730} %{F#4E734F}%{F-} %{B-} %percentage_used%%
background = ${colors.workspace-background}

[module/pkg]
type = custom/script
exec = updates-fedora
tail = true

[module/trash]
type = custom/script
exec = trashstatus --check
tail = true
click-left = trashstatus --empty %pid%
format-prefix = %{B#233730} %{F#4E734F}%{F-} %{B-}

[module/pulseaudio]
type = internal/pulseaudio
interval = 10
format-volume = %{A3:pavucontrol & disown:}<ramp-volume> <label-volume>%{A}
format-muted = <label-muted>
label-muted = %{A3:pavucontrol & disown:}%{A}
label-muted-foreground = ${colors.foreground-inactive}
ramp-volume-0 = %{B#233730} %{F#4E734F}%{F-} %{B-}
ramp-volume-1 = %{B#233730} %{F#4E734F}%{F-} %{B-}
ramp-volume-2 = %{B#233730} %{F#4E734F}%{F-} %{B-}

[module/network]
type = internal/network
interface = enp6s0
interval = 3.0
unknown-as-up = true
label-connected = %{F#4E734F}%{F-}
label-disconnected = 
label-disconnected-foreground = ${colors.alert}

[module/date]
type = internal/date
interval = 30
time = %a, %d de %b %H:%M
format = <label>
label = %{B#233730} %{F#4E734F}%{F-} %{B-} %time%