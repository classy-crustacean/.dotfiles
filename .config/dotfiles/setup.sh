#!/bin/sh
#First, make sure we are running as the user we want, and not accidentally using sudo
if whoami | grep -iq 'root'
then
	echo -n "[Dotfiles] Running as root is not advised, as the config will be applied to the root user. Continue? (y/n)"
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg
	if ! echo "$answer" | grep -iq "^y"
	then
		echo "[Dotfiles] Please re-run this script without sudo"
		exit
	fi
fi


#OS-Specific setup, have to differentiate between mac and linux distros
if uname | grep Darwin
then
	echo "[Dotfiles] Detected Mac operating system"
	echo "[Dotfiles] Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo "[Dotfiles] Installing fish, starship, and wget"
	/usr/local/bin/brew install fish wget

# Fedora
elif  cat /etc/os-release | grep -iq "fedora"
then
	echo "[Dotfiles] Detected distro Fedora"
	echo "[Dotfiles] Installing fish, vim, wget, curl, xsel, git, and util-linux-user for chsh"
	sudo dnf install fish vim wget curl xsel git util-linux-user -y

# Arch
elif cat /etc/os-release | grep -iq "arch"
then
	echo "[Dotfiles] Detected distro Arch"
	echo "[Dotfiles] Installing fish, vim, wget, curl, xsel, git, and chsh"
	sudo pacman -Sy fish vim wget curl xsel git chsh

# SUSE
elif cat /etc/os-release | grep -iq "suse"
then
	echo "[Dotfiles] Detected distro SUSE"
	echo "[Dotfiles] Installing fish, vim, wget, curl, xsel, and git"
	sudo zypper install fish vim wget curl xsel git

# Debian
elif cat /etc/os-release | grep -iq "debian"
then
	echo "[Dotfiles] Detected distro Debian"
	echo "[Dotfiles] Installing vim, wget, curl, fish, xsel and git"
	sudo apt-get update -qy
	sudo apt-get install vim wget curl fish xsel git -qy
fi

# Install Starship
echo "[Dotfiles] Installing Starship"
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

#Change shell to fish
chsh -s "$(which fish)"

echo "[Dotfiles] Installing oh-my-fish"
fish -c "$(curl -L https://get.oh-my.fish); exit"

echo "[Dotfiles] Installing bang-bang through oh-my-fish"
fish -c "omf install bang-bang; exit"

# make dotfiles alias to manage local repo
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

echo "[Dotfiles] Cloning .dotfiles repository"
git clone --bare "https://github.com/classy-crustacean/.dotfiles.git" $HOME/.dotfiles

dotfiles reset --hard
dotfiles checkout

#stop showing all files
dotfiles config --local status.showUntrackedFiles no

# make fetch url http, but push url ssh
dotfiles remote set-url origin "https://github.com/classy-crustacean/.dotfiles.git"
dotfiles remote set-url --push origin "git@github.com:classy-crustacean/.dotfiles.git"

