source $OTHER/env.zsh
grep -q 'flutter' <<< $devTools && export PATH="$PATH:$HOME/.local/opt/flutter/bin"
grep -q 'dotnet' <<< $devTools && export PATH="$PATH:$HOME/.dotnet"
grep -q 'cargo' <<< $devTools && source $HOME/.cargo/env
grep -q 'gem' <<< $devTools && export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
grep -q 'npm' <<< $devTools && export PATH="$PATH:$HOME/.local/npm/bin"
grep -q 'go' <<< $devTools && export PATH="$PATH:$(go env GOPATH)/bin"
grep -q 'android' <<< $devTools && export ANDROID_SDK_ROOT="$HOME/.android-sdk"
