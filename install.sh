#!/bin/sh
# this is to symlinkInstall configs for tmux, termite, vim and awesome.

function require {
	if [ `command -v $1` == "" ]; then
		echo "this script requires $1 to work, please symlinkInstall this and run the script again."
		exit
	fi
}

require git

DIR="$( cd "$( dirname "${SH_SOURCE[0]}" )" && pwd )"

function symlinkInstall {
	if [ ! -e "$2" ]; then
		ln -s "$DIR/$1" "$2"
	else
		echo "$2 file allready exists overwrite?(Y/N)"
		read ans
		if [ "$ans" == "Y" ] || [ "$ans" == "y" ]; then
			rm -rf "$2"
			ln -s "$DIR/$1" "$2"
		fi
	fi
}

echo "installing awesome config files..."
symlinkInstall "awesome" "$HOME/.config/awesome"
echo "installing termite config..."
symlinkInstall "termite/config" "$HOME/.config/termite/config"
echo "installing tmux config..."
symlinkInstall ".tmux.conf" "$HOME/.tmux.conf"

echo "installing vundle..."
if [ ! -e "$HOME/.vim/bundles/Vundle.vim" ]; then
	git clone  https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundles/Vundle.vim"
fi
symlinkInstall ".vimrc" "$HOME/.vimrc"

echo "installing powerline fonts..."
git clone  https://github.com/powerline/fonts.git "$DIR/fonts/"
sh "$DIR/fonts/install.sh"
rm -rf "$DIR/fonts/"

# todo: symlinkInstall prezto?
# git clone -q  --recursive https://github.com/sorin-ionescu/prezto.git "$HOM£/.zprezto"
echo "installing prezto config..."
symlinkInstall ".zpreztoc" "$HOME/.zpreztoc"
echo "done."
