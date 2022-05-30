set fish_greeting

set -x XDG_CURRENT_DESKTOP GNOME
#set -x MOZ_ENABLE_WAYLAND 1
#set -x GDK_BACKEND wayland

#set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/.fzf/bin $PATH
set -gx PATH /usr/lib/ccache $PATH

#set -x RUSTC_WRAPPER sccache
#set -x SCCACHE_CACHE_SIZE 20G

#if [ "$DESKTOP_SESSION" = "i3" ]
#    set (gnome-keyring-daemon --start | string split "=")
#    export SSH_AUTH_SOCK
#end
#
#if [ "$DESKTOP_SESSION" = "sway" ]
#    set (gnome-keyring-daemon --start | string split "=")
#    export SSH_AUTH_SOCK
#end
