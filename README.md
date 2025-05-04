# Personal Development Tools
Add the following to ~/.zshrc:

```sh
# Load dev-tools zshrc
source "$HOME/git/dev-tools/dotfiles/.zshrc"
```

## Environment Setup

## Install Homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install Rust
```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Install Github CLI
```sh
brew install gh
```

### Install or Update AWS CLI
```sh
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```
