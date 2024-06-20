function brews() {
    brew bundle --file=- <<EOF

    brew "git"
    brew "openssl"
    brew "libyaml" # should come after openssl
    brew "reattach-to-user-namespace"
    brew "ripgrep"
    brew "zsh"
    brew "neovim"
    brew "tmuxinator"
    brew "tmux"
    brew "direnv"
    brew "gpg2"
    brew "asdf"
    brew "stow"
    brew "fzf"
    brew "fd"
    brew "zsh-vi-mode"
    brew "git-delta"
    brew "rust"
    brew "cmake"
    brew "luarocks"
    brew "shfmt"
    brew "black"
    brew "tree"
    brew "htop"
    brew "gopls"
    brew "yaml-language-server"
    brew "bash-language-server"
    brew "typescript-language-server"

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
