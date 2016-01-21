set hidden
" remove menu bars in gui
set go-=m
set go-=T 
set go-=r
set go-=L

if !has('nvim')
	set nocompatible
endif

filetype off

" set runtime path and interllize vundle 
set rtp+=~/.vim/bundles/Vundle.vim
call vundle#begin("~/.vim/bundles")

" Vundle manage vundle
Plugin 'VundleVim/Vundle.vim'

"plugins go here for gui 
Plugin 'bling/vim-airline'

" navigation
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'easymotion/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'

"shell
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'

" intergartion
Plugin 'tpope/vim-fugitive'

" latex beacuse latex
Plugin 'lervag/vimtex'

" syntax/autocomplete plugins
Plugin 'syntastic'
Plugin 'Valloric/YouCompleteMe'

" colour schemes 
Plugin 'chriskempson/base16-vim'
Plugin 'flazz/vim-colorschemes'


call vundle#end()	"finish delcarations of plugins

" start inplemtation of plugins

if !has('nvim')
	" turn on colour coded 
	let g:color_coded_enabled = 1
	let g:color_coded_filetypes = ['c', 'cpp', 'objc']
endif

" make airline show.
let g:airline_powerline_fonts = 1
set laststatus=2 "make it show with no splits.

" nvim time.
if has('nvim')
	 let g:python3_host_prog = '/usr/bin/python3.5'
	 let g:python2_host_prog = '/usr/bin/python2.7'
endif

" start colour schemes 

colo molokai  
syntax on
set background=dark
set t_Co=256 "265 colors in terminal
let g:molokai_original=1 " set dark grey background
  
filetype plugin indent on " indenting 
set tabstop=4
set shiftwidth=4

" key configs

inoremap jk <ESC>
inoremap <ESC> <nop>
inoremap <c-c> <nop>

inoremap <up> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <down> <nop>

set encoding=UTF-8

" set working dir for gvim
if has('gui_running')
	cd ~/Documents/projects/ 
	set guifont=Liberation\ Mono\ for\ Powerline\ 10
endif
