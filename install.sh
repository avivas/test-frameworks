#!/bin/bash

if [ -d "$HOME/.sdkman/" ] ; then
  echo "Using installed sdk"
#  . ~/.bashrc
else
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

source $HOME/.sdkman/bin/sdkman-init.sh

sdk install java 15.0.1.hs-adpt