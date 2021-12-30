# Modified version of arrow

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="yellow"; fi

PROMPT='%{$fg[$NCOLOR]%}%c ➤ %{$reset_color%}'
RPROMPT='%{$fg[$NCOLOR]%}%p $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# See http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

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