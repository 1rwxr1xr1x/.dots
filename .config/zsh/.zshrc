# CLEAR SCREEEEEEEENNNNNNNNNNNNN
clear

# aliases & vars
[ -f "$XDG_CONFIG_HOME/zsh/conf.d/aliases.zsh" ] && source "$XDG_CONFIG_HOME/zsh/conf.d/aliases.zsh"
[ -f "$XDG_CONFIG_HOME/zsh/conf.d/vars.zsh" ] && source "$XDG_CONFIG_HOME/zsh/conf.d/vars.zsh"

# source modules
for f in "$XDG_CONFIG_HOME"/zsh/conf.d/*.zsh; do
    [ -f "$f" ] && source "$f"
done

source /data/data/com.termux/files/home/.config/broot/launcher/bash/br
