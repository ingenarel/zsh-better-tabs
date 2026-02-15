function cmd-rename(){
    local name
    case "$1" in
        nvim*)
            name=""
            ;;
        bash*|zsh*|sh*)
            name=""
            ;;
        fish*)
            name="󰈺"
            ;;
        ssh*)
            name="🖧"
            ;;
        man*)
            name="📖"
            ;;
        btop*|htop*|top*)
            name=""
            ;;
        yazi*)
            name="🗃️"
            ;;
        sudo*|doas*)
            name="🛡️"
            ;;
        git*|lazygit*)
            name=""
            ;;
        ncmpcpp*|rmpc*)
            name="🎵"
            ;;
        weechat*)
            name="󰰭"
            ;;
        iamb*)
            name="󰯊"
            ;;
        discordo*)
            name=""
            ;;
        neomutt*)
            name=""
            ;;
        aerc*)
            name="📧"
            ;;
        mpv*)
            name=""
            ;;
        *)
            name="$1"
            ;;
    esac
    echo "$name"
}

function pwd-rename(){
    gitRoot="$( git rev-parse --show-toplevel 2>/dev/null )"
    if [ -z "$gitRoot" ]; then
        realpath --canonicalize-missing "$PWD" | sed -e "s|$HOME|~|"
    else
        realpath --relative-base "$gitRoot/.." --canonicalize-missing "$PWD"
    fi
}

function zellij-dir-rename() {
    zellij action rename-tab "$( pwd-rename "$1" )" >/dev/null 2>&1
}

function zellij-cmd-rename() {
    zellij action rename-tab "$( cmd-rename "$1" )" >/dev/null 2>&1
}

function tmux-dir-rename() {
    tmux rename-window -t "$_ZSH_BETTER_TABS_CURRENT_TAB" "$( pwd-rename "$1" )" >/dev/null 2>&1
}

function tmux-cmd-rename() {
    tmux rename-window -t "$_ZSH_BETTER_TABS_CURRENT_TAB" "$( cmd-rename "$1" )" >/dev/null 2>&1
}

[ "$ZELLIJ" ] && {
    add-zsh-hook preexec zellij-cmd-rename
    add-zsh-hook precmd  zellij-dir-rename
}


[ "$TMUX" ] && {
    _ZSH_BETTER_TABS_CURRENT_TAB="$(tmux display-message -p '#{session_name}:#{window_index}')"
    export _ZSH_BETTER_TABS_CURRENT_TAB
    add-zsh-hook preexec tmux-cmd-rename
    add-zsh-hook precmd  tmux-dir-rename
}
