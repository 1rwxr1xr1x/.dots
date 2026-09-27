zmodload zsh/datetime
autoload -Uz add-zsh-hook

NEWLINE=$'\n'

# prompt char: λ if locale is UTF-8 
PROMPT_CHAR='λ'

_cmd_duration_start=''
_cmd_duration=''

prompt_preexec() {
    _cmd_duration_start=$EPOCHREALTIME
}

prompt_precmd() {
    _cmd_duration=''
    if [[ -n "$_cmd_duration_start" ]]; then
        local -F elapsed=$(( EPOCHREALTIME - _cmd_duration_start ))
        if (( elapsed >= 1 )); then
            local -ri secs=$(( elapsed % 60 ))
            local -ri mins=$(( (elapsed / 60) % 60 ))
            local -ri hours=$(( elapsed / 3600 ))
            _cmd_duration=' '
            (( hours > 0 )) && _cmd_duration+="${hours}h"
            (( mins > 0 )) && _cmd_duration+="${mins}m"
            (( secs > 0 )) && _cmd_duration+="${secs}s"
        fi
        unset _cmd_duration_start
    fi

    local pwd_short="${PWD/#$HOME/casper}"
    if (( ${#pwd_short} > 40 )); then
        local -a parts=(${(s:/:)pwd_short})
        local out="${parts[1]}"
        for (( i=2; i<=${#parts}; i++ )); do
            out+="/${parts[i][1]}"
        done
        _prompt_pwd=$out
    else
        _prompt_pwd=$pwd_short
    fi

    PROMPT="${NEWLINE}%F{yellow}${_prompt_pwd}%F{cyan}${_cmd_duration} %F{white}${PROMPT_CHAR}%f "   
}

add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd
