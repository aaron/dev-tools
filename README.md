# Personal Development Tools
Add the following to ~/.zshrc:

```sh
# Load dev-tools zshrc
source "$HOME/git/dev-tools/dotfiles/.zshrc"
```

## Environment Setup

### Install or Update AWS CLI
```sh
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```
