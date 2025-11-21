source "$HOME/.profile"

export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash-completion/bash_completion"
export HISTFILE="$XDG_STATE_HOME/bash/history"

# Ensure HISTFILE directory and file exist
if [ -n "$HISTFILE" ]; then
    histdir="$(dirname "$HISTFILE")"

    # Create directory if missing
    [ -d "$histdir" ] || mkdir -p "$histdir"

    # Create empty file if missing
    [ -f "$HISTFILE" ] || touch "$HISTFILE"
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

