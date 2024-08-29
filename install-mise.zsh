#!/bin/bash
curl https://mise.run | sh
~/.local/bin/mise --version
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> $HOME/.zsh/mise.zsh
