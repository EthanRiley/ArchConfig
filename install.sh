#!/bin/sh
# this is to symlinkInstall configs for tmux, termite, vim and awesome.

require() {
	if [ `command -v $1` == "" ]; then
		echo "this script requires $1 to work, please install this and run the script again."
		exit
	fi
}

require git

DIR="$( cd "$( dirname "${SH_SOURCE[0]}" )" && pwd )"

# change that if is install dir installs files as symlinks not the dir
symlinkInstall() {
	if [ ! -e "$2" ]; then

		if [ -d "$1" ]; then
			mkdir "$2"
			ln -s "$1/"* "$2/"
		else
			ln -s "$1" "$2"
		fi

		return 0
	else
		echo "$2 file allready exists overwrite?(Y/N)"
		read ans
		if [ "$ans" == "Y" ] || [ "$ans" == "y" ]; then
			rm -rf "$2"

			if [ -d "$1" ]; then
				mkdir "$2"
				ln -s "$1/"* "$2/"
			else
				ln -s "$1" "$2"
			fi
			return 0
		fi
	fi

	return 1
}

gitCloneInstall() {
	args=("$@")

	if [ ! -e ${args[$# - 1]} ]; then
		git clone $*
		return 0
	else
		echo "repository ${args[$# - 2]} allready exists at ${args[$# - 1]} overwrite?(Y/N)"
		read ans
		if [ "$ans" == "Y" ] || [ "$ans" == "y" ]; then
			rm -rf "${args[$# - 1]}"
			git clone $*
			return 0
		fi
	fi

	return 1
}


echo "installing awesome config files..."
symlinkInstall "$DIR/awesome" "$HOME/.config/awesome"


echo "installing termite configs..."
symlinkInstall "$DIR/termite" "$HOME/.config/termite"

echo "installing tmux config..."
symlinkInstall "$DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "installing solarized termite config..."
gitCloneInstall https://github.com/alpha-omega/termite-colors-solarized.git "$HOME/.config/termite/solarized"

#  get if exec worked
if [ $? == 0 ]; then
	echo "setting solarized dark as default config for termite..."
	symlinkInstall "$HOME/.config/termite/solarized/solarized-dark" "$HOME/.config/termite/config"
fi


echo "installing vundle..."
gitCloneInstall  https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundles/Vundle.vim"
symlinkInstall "$DIR/.vimrc" "$HOME/.vimrc"

if [ ![`command -v nvim` == ""] ]; then
	if [ ! -e "$HOME/.config/nvim/" ]; then
		mkdir "$HOME/.config/nvim"
	fi

	symlinkInstall "$DIR/.vimrc" "$HOME/.config/nvim/init.vim"
fi


echo "installing powerline fonts? (Y/N)"
read ans
if [ ans == "Y" ] || [ ans = "y" ]; then
	gitCloneInstall  https://github.com/powerline/fonts.git "$DIR/fonts/"

	#  get if exec worked
	if [ $? == 0 ]; then
		sh "$DIR/fonts/install.sh"
		rm -rf "$DIR/fonts/"
	fi
fi

# todo: symlinkInstall prezto?
echo "installing prezto config..."
gitCloneInstall -q  --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"

if [ $? == 0 ]; then
	rm -rf "$HOME/.zpreztorc"
fi

symlinkInstall "$DIR/.zpreztorc" "$HOME/.zpreztorc"

echo "done."

