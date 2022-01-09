#!/bin/sh
#TODO.md

DISTRIBUTION=""

check_linux_distribution () {

    if [ -f /etc/centos-release ]; then
        DISTRIBUTION="centos"
    elif [ -f /etc/debian_version ]; then
        DISTRIBUTION="debian"
    else
        echo 'WARN: Could not detect distro or distro unsupported'
        echo 'WARN: Trying to install ansible via pip without some dependencies'
        echo 'WARN: Not all functionality of ansible may be available'
    fi

    echo $DISTRIBUTION
}

install_ansible () {    
    if [ $(echo $(check_linux_distribution)) = "debian" ]; then
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
        apt-get update
        # Install via package
        apt-get update && \
        apt install software-properties-common && \
        add-apt-repository --yes --update ppa:ansible/ansible && \
        apt-get update && \
        apt-get install -y ansible
        chmod -R u-rwx,g+rwx,o+rwx ~/.ansible
    else
        echo 'WARN: Could not detect distro or distro unsupported'
        echo 'WARN: Trying to install ansible via pip without some dependencies'
        echo 'WARN: Not all functionality of ansible may be available'
    fi 
}

install_ansible