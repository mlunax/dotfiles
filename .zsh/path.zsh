# Flutter
source $OTHER/env.zsh
grep -q 'flutter' <<< $devTools && export PATH="$PATH:$HOME/.development/flutter/bin"
grep -q 'dotnet' <<< $devTools && export PATH="$PATH:$HOME/.dotnet"
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
grep -q 'npm' <<< $devTools && export PATH="$PATH:$HOME/.npm-global"
grep -q 'go' <<< $devTools && export PATH="$PATH:/usr/local/go/bin:$(/usr/local/go/bin/go env GOPATH)/bin" 
