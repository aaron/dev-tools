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
# Renabled for problems running parallel tests with ruby 3.4.2 on 4/10/25
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Set EDITOR to Visual Studio Code
export EDITOR="code -n"

# Shell prompt
export PS1="%n@%m %1~ %# "

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
alias rtc="rt;rc"

