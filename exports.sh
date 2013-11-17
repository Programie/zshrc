export EDITOR="vim" # Default editor
export HISTSIZE=100000 # Maximum amount of history items
export HISTFILE="$HOME/.zsh_history" # Path to your history file
export SAVEHIST=$HISTSIZE # Same as HISTSIZE
export PS1=$'%{\e[1;33m%}%n%{\e[0m%}@%{\e[1;31m%}%M%{\e[0m%}:%{\e[1;36m%}%~%{\e[0m%} $ ' # Left prompt design
export GREP_OPTIONS="--color=auto" # Enable highlighting of the matches
export GREP_COLOR="1;32" # Set highlighting color