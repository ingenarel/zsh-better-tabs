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
        *)
            name="$1"
            ;;
    esac
    echo "$name"
}

function pwd-rename(){
    command -v starship > /dev/null 2>&1 && {
        starship prompt |
        # ansi sequence regex from:
        # https://github.com/iarchean/tmux-starship/blob/ae995df7ac18175719da69430521f7d6f3e39a4e/scripts/helper.sh#L17C14-L17C44
        sed -E 's/\x1b\[[0-9;()]*[a-zA-Z@]?//g; s/%\{|%\}//g; s/\s*$//g' |
        head -n2 |
        tail -n1
        } || {
        echo "${PWD//#$HOME/~}"
    }
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
