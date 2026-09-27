if (( $+commands[bat] )); then
    alias lscpu="lscpu | bat -Ppl cpuinfo"
    alias sensors="sensors | bat -Ppl cpuinfo"
    alias lsblk="lsblk | bat -Ppl conf"
    alias lsmod="lsmod | bat -Ppl conf"
fi

if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

alias tmac="tmux new-session -A -s main"
alias tmcd="tmux set-option -t \$(tmux display-message -p '#S') default-path \$(pwd)"
alias vi="nvim"
alias vim="nvim"
alias e="$EDITOR"
alias rsync-all="rsync -av --delete"

if (( $+commands[helix] )); then
    (( $+commands[hx] )) || alias hx="helix"
fi

alias cp="cp -r"
alias rsync="rsync -havzP --stats"

if (( $+commands[eza] )); then
    alias ls="eza -a"
    alias l="eza -a"
    alias ll="eza -l"
else
    alias ls='ls --color=auto -A'
    alias l='ls --color=auto -A'
    alias ll='ls -l --color=auto -A'
fi

if (( $+commands[git] )); then
    alias g="git"
    alias ga="git add"
    alias gaa="git add --all"
    alias gc="git commit"
    alias gcd='git commit -m "$(date +"%Y-%m-%d %H:%M")"'
    alias gca="git commit -a"
    alias gd="git diff"
    alias gl="git pull"
    alias gp="git push"
    alias gs="git status"
    alias glog="git log --oneline --graph"
    alias gcl="git clone --depth 1"
fi

alias dl-ytm="yt-dlp -x --audio-format mp3"
alias dl-yt="yt-dlp --format mp4"
alias venv="source .venv/bin/activate"
alias h='eval "$(horse)"'

(( $+commands[nixos-rebuild] )) && alias ne="cd /etc/nixos/ && $EDITOR ./configuration.nix"

alias unprint="rg -n -P '[^\x00-\x7F\x{2800}-\x{28FF}]'"
alias dots='git --git-dir=$HOME/.dots --work-tree=$HOME'
