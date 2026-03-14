source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
#
set -gx EDITOR nvim
set -gx VISUAL nvim

# ALIAS
alias update="sudo pacman -Syu"
alias snapshot="pacman -Qqe > ~/dotfiles/packages/pkglist.txt"
alias input="sudo libinput debug-events"
