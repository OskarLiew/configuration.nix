# Set ZSH config path
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Set default editors
export EDITOR="nvim"
export VISUAL="nvim"

# Set ZSH environment variables
export HISTDUP="erase"

# Color output
export LESS='-R --use-color -Dd+r$Du+b$'
export MANPAGER="less -R --use-color -Dd+r -Du+b"

# bat
export BAT_THEME="TwoDark"

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"

# Ranger
export RANGER_LOAD_DEFAULT_RC=false
