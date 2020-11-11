#!/bin/sh

if [ -d "$HOME/.sdkman/" ] ; then
  echo "Using installed sdk"
else
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
