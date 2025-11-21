# ----------------
# Interactive & Important setting
# ----------------
[[ $- != *i* ]] && return
fastfetch

# --------------
# Autocompletion
# --------------
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion


# ----------------
# Shared configs
# ----------------
source "$dotconf/shells/.aliases"
source "$dotconf/shells/.functions"

# NodeJS
# source /usr/share/nvm/init-nvm.sh


# ----------------
# Prompt
# ----------------
PS1='[\u@\h \W]\$ '

if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi
