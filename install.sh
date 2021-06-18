#!/bin/bash

#-> Install k6
function install_k6 {
  if ! command -v k6 &> /dev/null 
  then
    echo "Start: Install k6 ----------------------------------------------" 
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61
    echo "deb https://dl.bintray.com/loadimpact/deb stable main" | sudo tee -a /etc/apt/sources.list
    sudo apt-get update
    sudo apt-get install k6 -y
    echo "End  : Install k6 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" 
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
    echo "Start: Install sdkman ----------------------------------------------" 
    sudo apt install curl unzip zip -y
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    echo "End  : Install sdkman >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" 
  fi

  source $HOME/.sdkman/bin/sdkman-init.sh
}
#-----------------------------------------------------------------------------------------------

#-> Install gvm
function install_gvm {
  if ! command -v gvm &> /dev/null 
  then
    echo "Start: Install GVM >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" 
    sudo apt-get install binutils bison gcc make -y
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    source ~/.gvm/scripts/gvm
    echo "End  : Install GVM >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" 
  else
    echo "Using installed gvm"
  fi
}
#----------------------------------------------------------------------------------------------


#-> Install rustup
function install_rustup {
  if ! command -v rustup &> /dev/null 
  then
    echo "Start: Install RUST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" 
    sudo apt install curl -y
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    echo "End  : Install RUST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" 
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