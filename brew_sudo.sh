function brews() {
    brew bundle --file=- <<EOF

    brew "git"
    brew "openssl"
    brew "libyaml" # should come after openssl
    brew "reattach-to-user-namespace"
    brew "zsh"
    brew "neovim"
    brew "tmuxinator"
    brew "tmux"
    brew "direnv"
    brew "gpg2"
    brew "asdf"
    brew "stow"

EOF
}

function casks() {
    brew bundle --file=- <<EOF

    cask "alfred"
    cask "vlc"
    cask "spectacle"
    cask "docker"
    cask "alacritty"
    cask "firefox"

EOF
}

brews
casks