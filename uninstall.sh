#!/bin/bash

#-> Uninstall k6
function uninstall_k6 {
  if ! command -v k6 &> /dev/null 
  then
    echo "k6 no installed"
  else
    echo "Uninstall k6"
    sudo apt-get --purge remove k6
  fi
}
#-----------------------------------------------------------------------------------------------

#-> Uninstall sdkman
function uninstall_sdkman {
  if [ -d "$HOME/.sdkman/" ] ; then
    echo "Uninstall sdkman"
    sudo apt --purge remove curl unzip zip
    rm -rf ~/.sdkman
  else
    echo "sdkman no installed"
  fi
}
#-----------------------------------------------------------------------------------------------

#-> Uninstall gvm
function uninstall_gvm {
  if ! command -v gvm &> /dev/null 
  then
    echo "gvm no installed"
  else
    echo "Uninstall gvm"
    sudo apt-get --purge remove binutils bison gcc make
    rm -rf ~/.gvm    
  fi
}
#----------------------------------------------------------------------------------------------


#-> Uninstall rustup
function uninstall_rustup {
  if ! command -v rustup &> /dev/null 
  then
    echo "Rustup no installed"
  else
    echo "Uninstall rustup"
    sudo apt --purge remove curl
    rustup self uninstall
  fi
}
#-------------------------


#-> Uninstall tools
uninstall_k6
uninstall_sdkman 
uninstall_gvm
uninstall_rustup