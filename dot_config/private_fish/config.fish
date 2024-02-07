if status is-interactive
    # Commands to run in interactive sessions can go here
end
#set fish_greeting="CASH MONEY SWAAGG"

##CUSTOM SHIT

#set -Ua fish_user_paths /usr/local/sbin
#set -Ua fish_user_paths /usr/local/bin
#set -Ua fish_user_paths /usr/bin
#set -Ua fish_user_paths /usr/sbin
#set -Ua fish_user_paths /sbin
#set -Ua fish_user_paths /bin

#set -U fish_user_paths /usr/local/bin $fish_user_paths

set -Ua fish_user_paths "$HOME/.cargo/bin"

# Build everything with clang
set -Ux CC clang
set -Ux CXX clang++


set -gx LIBVIRT_DEFAULT_URI "qemu:///system"
##CUSTOM SHIT

function fish_greeting
    echo (set_color green)"💵💵💵 CASH MONEY SWAAGG GANG 💵💵💵"
    echo (set_color white) "🕊️🕊️🕊️" (set_color red) "WHAT EVIL SHALL I DO TODAY?" (set_color white) "🕊️🕊️🕊️"
    echo "It's" (set_color yellow;date +%T;set_color normal)
end

#if status is-interactive
#  cd $HOME
#end
#

set bashrc $HOME/.bashrc
[ -f "$bashrc" ] && source "$bashrc"

#NIXOS
#set -x XDG_DATA_DIRS /home/sweat/.nix-profile/share:$XDG_DATA_DIRS

set -x PATH $PATH $HOME/go/bin
set -x PATH $PATH /usr/lib/ruby/gems/3.2.0/bin

function startshadow
    # Kill any running instance of ss-local
    if pgrep ss-local > /dev/null
        pkill ss-local
        echo "Existing ss-local process terminated."
        # Optional: Add a small delay to ensure the process is fully terminated
        sleep 1
    end

    # List all .json files in /etc/shadowsocks
    set configs (ls /etc/shadowsocks/*.json)

    # Check if there are any configs
    if test (count $configs) = 0
        echo "No configurations found in /etc/shadowsocks."
        return 1
    end

    # Present the configs to the user
    echo "Available configurations:"
    for i in (seq 1 (count $configs))
        echo "$i. $configs[$i]"
    end

    # Ask the user to select a config
    echo -n "Enter the number of the configuration you want to use: "
    set choice (read)

    # Check for valid input
    if not string match -qr '^[0-9]+$' $choice
        echo "Invalid selection."
        return 1
    end

    # Start ss-local with the selected configuration
    ss-local -c $configs[$choice] -f /tmp/ss.pid
end

function patchcurl
    set url $argv[1]
    set raw_content (curl -s "$url")
    set subject (echo $raw_content | grep 'Subject: \[PATCH' | sed 's/Subject: \[PATCH[^]]*\] //' | cut -c 1-50)
    set safe_filename (echo $subject | tr ' ' '_' | tr -cd '[:alnum:]_').patch
    
    # Ensure filename does not start with a non-alphanumeric character
    if not string match -r '^[[:alnum:]]' $safe_filename
        set safe_filename "patch_"$safe_filename
    end

    echo $raw_content > $safe_filename
    echo "Saved to $safe_filename"
end

#function distrobox
#    if test $argv[1] = "enter"
#        env TERM=xterm-256color distrobox $argv
#    else
#        distrobox $argv
#    end
#end

function lowcolors
    set -gx TERM "xterm-256color"
    echo "Terminal set to low color mode."
end

function waylandscreenshare
    nohup flatpak run org.kde.xwaylandvideobridge &
end

function vim
    nvim $argv
end

function sudo
    doas $argv
end

function ls
    /usr/bin/eza $argv
end

#load_nvm > /dev/stderr
