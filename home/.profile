export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CACHE_HOME="$HOME"/.cache
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export GTK_USE_PORTAL=1
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export EDITOR=nvim
export MOZ_GTK_TITLEBAR_DECORATION=client
# Other Programs
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet 

export GOPATH="$XDG_DATA_HOME"/go

export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel

export CARGO_HOME="$XDG_DATA_HOME"/cargo  
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js   
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm                             

export PYTHONUSERBASE="$XDG_DATA_HOME"/python
export PYLINTHOME="$XDG_CACHE_HOME"/pylint

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

export PROTON_ENABLE_WAYLAND=1

# Personal
export dotfiles="$HOME"/dotfiles-nix
export dotconf="$dotfiles"/home/.config
export PATH="$HOME/.local/bin/:$PATH"

source "$XDG_CACHE_HOME/wal/colors-tty.sh"
