#!/bin/bash

#-> Install k6
function install_k6 {
  if ! command -v k6 &> /dev/null 
  then
    echo "Start: Install k6 ----------------------------------------------" 

    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
    echo "deb https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
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
    echo "Start: Install GVM ----------------------------------------------" 
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
    echo "Start: Install RUST ----------------------------------------------" 
    sudo apt install curl -y
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
    echo "End  : Install RUST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" 
  else
    echo "Using installed rustup"
  fi
}
#-------------------------

#-> Install docker
function install_docker {

  sudo apt-get update

  sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    -y

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io -y

  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

#-> Install tools
install_docker
install_k6
install_sdkman
install_gvm
install_rustup

# Install hello world
cd ./hello-world/
./install.sh
cd ../


# Install crud-mysql
cd ./crud-mysql/
./install.sh
cd ../