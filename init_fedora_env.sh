#!/bin/sh

export LC_ALL='C.UTF8'

echo "Start detecting dependency packages"

# Check whether the relevant dependencies have been installed
groupkg="development-tools"
depenpkg=("nasm" "automake" "flex" "libX11-devel" "libXext-devel" "qemu" "uuid-devel" "git" "gcc-c++" "libuuid" "libuuid-devel")

if dnf group list --installed | grep -q "$groupkg"; then
  echo -e "\e[32mGroup package $groupkg installed\e[0m"
else
  echo "Group package $groupkg not installed"
  echo "Install dependent repos"
  sudo dnf group install -y "$groupkg"
fi

for package in "${depenpkg[@]}"
do
    # Use dnf list installed to check
    if ! dnf list --installed "$package" &> /dev/null; then
        echo "Package '$package' not installed"
        sudo dnf install -y $package
    else
        echo -e "\e[32mPackage '$package' installed\e[0m"
    fi
done

