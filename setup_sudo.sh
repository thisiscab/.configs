#!/bin/bash

function setup() {
    setupBrew

    #configureMac
}

function configureMac() {
    /bin/bash ~/src/.configs/macos_sudo
}

function setupBrew() {
    echo "Installing Homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    echo "Updating Homebrew ..."
    brew update --force

    echo "Installing Homebrew stuff ... "
    /bin/bash ./brew_sudo.sh

    if [[ -f "$HOME/src/.configs_personal" ]]; then
        echo "Installing Personal Homebrew stuff ... "
        /bin/bash /$HOME/src/.configs_personal/brew_sudo.sh
    fi

    # if [[ -f "$HOME/src/.configs_work" ]]; then
    #     echo "Installing Work Homebrew stuff ... "
    #     /bin/bash /$HOME/src/.configs_work/brew_sudo.sh
    # fi

}

setup
