#!/bin/sh
# this is to symlinkInstall configs for tmux, termite, vim and awesome.

function require {
	if [ `command -v $1` == "" ]; then
		echo "this script requires $1 to work, please install this and run the script again."
		exit
	fi
}

require git

DIR="$( cd "$( dirname "${SH_SOURCE[0]}" )" && pwd )"

function symlinkInstall {
	if [ ! -e "$2" ]; then
		ln -s "$DIR/$1" "$2"
		return 0
	else
		echo "$2 file allready exists overwrite?(Y/N)"
		read ans
		if [ "$ans" == "Y" ] || [ "$ans" == "y" ]; then
			rm -rf "$2"
			ln -s "$DIR/$1" "$2"
			return 0
		fi
	fi

	return 1
}

function gitCloneInstall {
	args=("$@")

	if [ ! -e ${args[$#]} ]; then
		git clone $*
		return 0
	else
		echo "repository ${args[$# - 2]} allready exists at ${args[$# - 1]} overwrite?(Y/N)"
		read ans
		if [ "$ans" == "Y" ] || [ "$ans" == "y" ]; then
			rm -rf "$2"
			git clone $*
			return 0
		fi
	fi

	return 1
}


echo "installing awesome config files..."
symlinkInstall "awesome" "$HOME/.config/awesome"


echo "installing termite config..."
symlinkInstall "termite/config" "$HOME/.config/termite/config"


echo "installing tmux config..."
symlinkInstall ".tmux.conf" "$HOME/.tmux.conf"


echo "installing vundle..."
gitCloneInstall  https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundles/Vundle.vim"
symlinkInstall ".vimrc" "$HOME/.vimrc"

if [ `command -v nvim` != "" ]; then
	if [ ! -e "$HOME/.config/nvim/" ]; then
		mkdir $HOME/.config/nvim
	fi

	symlinkInstall ".vimrc" "$HOME/.config/nvim/init.nvim"
	gitCloneInstall https://github.com/VundleVim/Vundle.vim.git "$HOME/.config/bundles/Vundle.vim"
fi


echo "installing powerline fonts..."
gitCloneInstall  https://github.com/powerline/fonts.git "$DIR/fonts/"

if [ $? == 0 ]; then
	sh "$DIR/fonts/install.sh"
	rm -rf "$DIR/fonts/"
fi


# todo: symlinkInstall prezto?
echo "installing prezto config..."
gitCloneInstall -q  --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
symlinkInstall ".zpreztoc" "$HOME/.zpreztoc"

echo "done."
