#!/bin/bash
install_on_ubuntu_or_kali() {
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt update
    sudo apt install -y python3.7 python3.7-venv python3.7-dev
}
install_on_termux() {
    pkg update -y
    pkg install -y python
    if [[ $(python --version) == *"3.7"* ]]; then
        echo "Python 3.7 is already installed."
    else
        echo "Python 3.7 is not available directly on Termux."
        echo "Consider using an alternative method or source-based installation."
    fi
}
install_from_source() {
    sudo apt update
    sudo apt install -y wget build-essential libssl-dev zlib1g-dev \
        libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev \
        libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev \
        libffi-dev

    wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
    tar -xvzf Python-3.7.9.tgz
    cd Python-3.7.9 || exit

    ./configure --enable-optimizations
    make -j "$(nproc)"
    sudo make altinstall

    cd ..
    rm -rf Python-3.7.9 Python-3.7.9.tgz
}
if grep -qi "ubuntu" /etc/os-release || grep -qi "kali" /etc/os-release; then
    echo "Detected Ubuntu or Kali Linux."
    install_on_ubuntu_or_kali
elif [[ $(uname -o) == "Android" ]]; then
    echo "Detected Termux environment."
    install_on_termux
else
    echo "Linux distribution not directly supported. Installing from source."
    install_from_source
fi
if python3.7 --version >/dev/null 2>&1; then
    echo "Python 3.7 successfully installed!"
else
    echo "Python 3.7 installation failed. Please check the logs."
fi
