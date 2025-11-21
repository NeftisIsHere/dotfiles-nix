# ----------------
# Interactive & Important setting
# ----------------
[[ -o interactive ]] || return
fastfetch

# --------------
# Autocompletion
# --------------
zstyle :compinstall filename '"$dotconf"/zsh/.zshrc'
setopt auto_pushd

# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

# Completion files: Use XDG dirs
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache

autoload -U compinit && compinit -u -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION

zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.


# ----------------
# Shared configs
# ----------------
source "$dotconf/shells/.aliases"
source "$dotconf/shells/.functions"

# Node JS
source /usr/share/nvm/init-nvm.sh


# ----------------
# Prompt
# ----------------
PS1='[\u@\h \W]\$ '

if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi
