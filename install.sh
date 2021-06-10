#!/bin/bash

#-> Install k6
function install_k6 {
  if ! command -v k6 &> /dev/null 
  then
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61
    echo "deb https://dl.bintray.com/loadimpact/deb stable main" | sudo tee -a /etc/apt/sources.list
    sudo apt-get update
    sudo apt-get install k6
  else
    echo "Using installed k6"
  fi
}
#-----------------------------------------------------------------------------------------------

#-> Install sdkman
function install_sdkman {
  if [ -d "$HOME/.sdkman/" ] ; then
    echo "Using installed sdkman"
  else
    sudo apt install curl unzip zip
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
  fi

  source $HOME/.sdkman/bin/sdkman-init.sh
}
#-----------------------------------------------------------------------------------------------

#-> Install gvm
function install_gvm {
  if ! command -v gvm &> /dev/null 
  then
    sudo apt-get install bison
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    # source ~/.gvm/bin/gvm
  else
    echo "Using installed gvm"
  fi
}
#----------------------------------------------------------------------------------------------


#-> Install rustup
function install_rustup {
  if ! command -v rustup &> /dev/null 
  then
    sudo apt install curl
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/bin
  else
    echo "Using installed rustup"
  fi
}
#-------------------------


#-> Install tools
install_k6
install_sdkman 
install_gvm
install_rustup

# Install hello world
cd ./performance/hello-world/
./install.sh
cd ../..