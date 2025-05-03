# Load rbenv automatically by appending
# the following to ~/.zshrc:
eval "$(rbenv init - zsh)"

# Add dev-tools bin to path
DEV_TOOLS_BIN="$(dirname $(cd "$(dirname "${(%):-%N}")" && pwd))/bin"
export PATH="$DEV_TOOLS_BIN:$PATH"

# Add homebrew mysql to path
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# Fix rails test errors
# https://github.com/rails/rails/issues/38560
# Try removing when ruby 3.2.0 is updated
# Re-nabled for problems running parallel tests with ruby 3.4.2 on 4/10/25
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Set EDITOR to Visual Studio Code
export EDITOR="code -n"

# Shell prompt
export PS1="%F{blue}%1~%f %# "

# Show git branch in right prompt
# https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ":vcs_info:git:*" formats "%F{240}%b%f"
zstyle ':vcs_info:*' enable git

# Aliases
alias be="bundle exec"
alias c="clear"
alias console="bin/rails console"
alias db_reload="bin/rails db:drop;bin/rails db:create;bin/rails db:schema:load;bin/rails db:fixtures:load"
alias fixtures="bin/rails db:fixtures:load"
alias migrate="bin/rails db:migrate"
alias paprika="open -n /Applications/Paprika\ Recipe\ Manager\ 3.app/"
alias rc="bin/rubocop"
alias rt="bin/rails test"
alias rta="bin/rails test:all"
alias rtc="rt;rc"

# Enable Docker CLI completions
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
