PATH_add "$mod_ranger_sw"
export mod_ranger_root
export mod_ranger_sw

export RANGER_LOAD_DEFAULT_RC=FALSE

alias rr=ranger
alias rcd='ranger-cd'

export mod_ranger_cdfile="$(mktemp -t rrcd.XXXXXX)"

rrcd() {
    local dir="$( cat "${mod_ranger_cdfile:-$(pwd)}" )"
    [[ $dir ]] && cd -- "$dir"
}
ranger-cd() {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "$@"
    test -f "$tempfile" &&
        if [ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]; then
        cd -- "$( cat "${tempfile:-$(pwd)}" )"
    fi
    rm -f -- "$tempfile"
}

# This binds Ctrl-O to ranger-cd:
# bind '"\C-o":"ranger-cd\C-m"'
