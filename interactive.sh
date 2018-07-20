PATH_add "$mod_ranger_sw"
PATH_add "$mod_ranger_root/bin.d"
export mod_ranger_root
export mod_ranger_sw

RANGER_LOAD_DEFAULT_RC=FALSE

alias rr=ranger
alias rcd='ranger-cd'

function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
        if [ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# This binds Ctrl-O to ranger-cd:
bind '"\C-o":"ranger-cd\C-m"'
