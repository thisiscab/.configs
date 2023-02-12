#!/bin/bash

function setup() {
    #setVimPluginManager 
    #setupBrew 
    setDotFiles
    # setShell
    #setAsdfVersionManager
    #
    #mkdir -p ~/src/personal/tmp
    #mkdir -p ~/src/personal/tmp/.git
    # configureMac

    echo "Run $(brew --prefix)/opt/fzf/install"
}

function setVimPluginManager() {
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

function configureMac() {
    sh ~/src/.configs/macos_user
}

function setShell() {
    case "$SHELL" in
    */zsh)
        ;;
    *)
        chsh -s "/bin/zsh" "$USER"
    esac
}

function setAsdfVersionManager() {
    install_asdf_plugin "ruby" "https://github.com/asdf-vm/asdf-ruby.git"
    install_asdf_plugin "nodejs" "https://github.com/asdf-vm/asdf-nodejs.git"
    install_asdf_plugin "python" "https://github.com/danhper/asdf-python"
    install_asdf_plugin "rust" "https://github.com/asdf-community/asdf-rust.git"
    install_asdf_plugin "golang" "https://github.com/kennyp/asdf-golang.git"

    echo "Installing latest Ruby ..."
    install_asdf_language "ruby"

    echo "Installing latest Node ..."
    sh "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring"
    install_asdf_language "nodejs"

    echo "Installing Python2.7 ..."
    install_asdf_language "python" "2.7"

    echo "Installing latest Python3.10 ..."
    install_asdf_language "python" "3.10"

    install_asdf_language "golang" "1.19.3"

    asdf global python 3.10 2.7
}

function setDotFiles() {
    if [ -z $STOW_FOLDERS ]; then
        declare -a STOW_FOLDERS=("alacritty" "git" "nvim" "tmux" "tmuxinator" "zsh" "asdf" "git" ".bin" "codespell")
        ARRAY_LENGTH=${#STOW_FOLDERS[@]}
    fi

    for (( i=0; i<${ARRAY_LENGTH}; i++ ));
    do
        if [ "${STOW_FOLDERS[$i]}" == ".bin" ]; then
                mkdir -p $HOME/.bin
                stow --adopt -t $HOME/.bin -d ${STOW_FOLDERS[$i]} .bin
        elif [ "${STOW_FOLDERS[$i]}" == "tmuxinator" ]; then
                mkdir -p $HOME/.tmuxinator
                stow --adopt -t $HOME/.tmuxinator -d ${STOW_FOLDERS[$i]} tmuxinator
        else
                stow --adopt -R -t $HOME ${STOW_FOLDERS[$i]}
        fi
    done

    # if [[ -f "$HOME/src/.configs_personal/setup_user.sh" ]]; then
    #     sh $HOME/src/.configs_personal/setup_user.sh
    # fi
    #
    # if [[ -f "$HOME/src/.configs_work" ]]; then
    #     sh $HOME/src/.configs_work/setup_user.sh
    # fi
}

function install_asdf_plugin() {
  local name="$1"
  local url="$2"

  if ! asdf plugin-list | grep -Fq "$name"; then
    asdf plugin add "$name" "$url"
  fi
}

function install_asdf_language() {
  local language="$1"
  local version="$2"

  if [ -z $version ]; then
    version="$(asdf list-all "$language" | grep -v "[a-z]" | tail -1)"
  fi

  echo $language
  echo $version
  if ! asdf list "$language" | grep -Fq "$version"; then
    asdf install "$language" "$version"
    asdf global "$language" "$version"
  fi
}

function setupBrew() {
    echo "Installing Homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    echo "Updating Homebrew ..."
    brew update --force

    echo "Installing Homebrew stuff ... "
    /bin/bash ./brew_user.sh

    if [[ -f "$HOME/src/.configs_personal" ]]; then
        echo "Installing Personal Homebrew stuff ... "
        /bin/bash /$HOME/src/.configs_personal/brew_user.sh
    fi

    # if [[ -f "$HOME/src/.configs_work" ]]; then
    #     echo "Installing Work Homebrew stuff ... "
    #     /bin/bash /$HOME/src/.configs_work/brew_sudo.sh
    # fi

}

setup
