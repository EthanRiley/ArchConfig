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

# make configs executable - so bspwm works
chmod -R +x $DIR

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

			# don't do dis if $2 is dir -rf is dangerous otherwise
			if [ ! -d "$2" ]; then
				rm -rf "$2"
			else
				rm -rf "$2/"*
			fi

			if [ -d "$1" ]; then
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

# new awesome version :( the configs do not work changing to bspwm
# echo "installing awesome config files..."
# symlinkInstall "$DIR/awesome" "$HOME/.config/awesome"

echo "installing bspwm configs..."
symlinkInstall "$DIR/bspwm" "$HOME/.config/bspwm"

echo "installing sxhkd configs..."
symlinkInstall "$DIR/sxhkd" "$HOME/.config/sxhkd"

echo "installing wallpapers"
symlinkInstall "$DIR/wallpapers" "$HOME/wallpapers"

echo "installing tmux config..."
symlinkInstall "$DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "setting solarized dark as default config for termite..."
symlinkInstall "$DIR/termite/config" "$HOME/.config/termite/config"
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
if [ $ans == "Y" ] || [ $ans = "y" ]; then
	gitCloneInstall  https://github.com/powerline/fonts.git "$DIR/fonts/"

	#  get if exec worked
	if [ $? == 0 ]; then
		sh "$DIR/fonts/install.sh"
		rm -rf "$DIR/fonts/"
	fi
fi

echo "installing prezto config..."

gitCloneInstall -q  --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"

if [ $? == 0 ]; then

	if [ -e "$HOME/.zshrc" ]; then
		echo "backing up zshrc, is being replaced by prezto version, your old .zshrc is saved as .zshrc.bak"
		mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
	fi

	## cannot use symlinkInstall due to the fact that the filenames of the symlink are not the same
	for dotfiledir in `ls $HOME/.zprezto/runcoms/*`; do
		for dotfile in ${dotfiledir#"$HOME/.zprezto/runcoms/"}; do
			ln -s  $dotfiledir "$HOME/."$dotfile
		done
	done

	rm -f "$HOME/.zpreztorc"
	rm -f "$HOME/.zprofile"

	# cannot symlinkInstall dir bc. ya don't want to delete home directory
	symlinkInstall "$DIR/preztoconfig/.zprofile" "$HOME/.zprofile"
	symlinkInstall "$DIR/preztoconfig/.zpreztorc" "$HOME/.zpreztorc"
fi

echo "done."
