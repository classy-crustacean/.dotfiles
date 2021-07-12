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
	/usr/local/bin/brew install fish starship wget
else
	echo "[Dotfiles] Detected Linux operating system"
	#fedora
	if cat /etc/os-release | grep -iq "fedora"
	then
		echo "[Dotfiles] Detected distro Fedora"
		echo "[Dotfiles] Installing fish, vim, wget, curl, xsel, and util-linux-user for chsh"
		sudo dnf install zsh vim wget curl xsel util-linux-user
	elif cat /etc/os-release | grep -iq "arch"
	then
		echo "[Dotfiles] Detected distro arch"
		echo "[Dotfiles] Installing fish, vim, wget, curl, xsel, and starship"
		sudo pacman -Sy fish vim wget curl xsel starship
	fi
fi

#Change shell to fish
chsh -s "$(which fish)"

echo "[Dotfiles] Installing vim-plug"
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "[Dotfiles] Installing oh-my-fish"
fish "$(curl -L https://get.oh-my.fish)"

echo "[Dotfiles] Installing bang-bang through oh-my-fish"
fish -c "omf install bang-bang; quit"

make dotfiles alias to manage local repo
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

echo "[Dotfiles] Cloning .dotfiles repository"
git clone --bare "https://github.com/classy-crustacean/.dotfiles.git" $HOME/.dotfiles

dotfiles reset --hard
dotfiles checkout

#stop showing all files
dotfiles config --local status.showUntrackedFiles no

echo "[Dotfiles] Installing Vim Plugins"
vim -c "PlugInstall | qa!"
