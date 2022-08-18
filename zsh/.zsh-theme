# Modified version of arrow
# for code in {000..255}; do print -P -- "$code: %F{$code}Color%f"; done

COLORA="012" # light blue-ish
COLORB="011" # or yellow

RPROMPT='%F{$COLORB} $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# See http://geoff.greer.fm/lscolors/
# export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
# export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
# export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function parse_git_dirty() {
    local SUBMODULE_SYNTAX=''
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
            SUBMODULE_SYNTAX="--ignore-submodules=dirty"
    fi
    if [[ -n $(git status -s ${SUBMODULE_SYNTAX}  2> /dev/null) ]]; then
        echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
        echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
}

VIM_NORMAL_PROMPT="%F{$COLORA}%c ➤"
VIM_INSERT_PROMPT="%F{$COLORB}%c ➤"
PROMPT='%F{$COLORB}%c ➤ %{$reset_color%}'
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
function zvm_after_select_vi_mode() {
    case $ZVM_MODE in
        $ZVM_MODE_NORMAL)
            PROMPT_MODE="$VIM_NORMAL_PROMPT"
            ;;
        $ZVM_MODE_INSERT)
            PROMPT_MODE="$VIM_INSERT_PROMPT"
            ;;
        $ZVM_MODE_VISUAL)
            PROMPT_MODE="$VIM_NORMAL_PROMPT"
            ;;
        $ZVM_MODE_VISUAL_LINE)
            PROMPT_MODE="$VIM_NORMAL_PROMPT"
            ;;
    esac

    PROMPT="$PROMPT_MODE %{$reset_color%}"
}
