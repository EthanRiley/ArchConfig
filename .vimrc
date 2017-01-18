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

" have diffrent path for nvim
set rtp+=~/.vim/bundles/Vundle.vim
let BundlePath = "~/.vim/bundles"

if has('nvim')
	"allow 256 colours
	set termguicolors

	let BundlePath = "~/.confg/nvim/bundles/"

	"setup python so can be used for plugins
	let g:python3_host_prog = '/usr/bin/python3.5'
	let g:python2_host_prog = '/usr/bin/python2.7'
end

call vundle#begin(BundlePath)

" Vundle manage vundle
Plugin 'VundleVim/Vundle.vim'

"plugins go here for gui
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" navigation
Plugin 'easymotion/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'

" cs <surrounding key> <new char to surround key>
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'

" git intergartion
Plugin 'tpope/vim-fugitive'

" latex beacuse latex
Plugin 'lervag/vimtex'

" syntax/autocomplete plugins
Plugin 'syntastic'
Plugin 'skammer/vim-css-color'

" colour schemes
Plugin 'chriskempson/base16-vim'
Plugin 'dracula/vim'
Plugin 'morhetz/gruvbox'
Plugin 'ltercation/vim-colors-solarized'
Plugin 'chriskempson/vim-tomorrow-theme'

" install nvim only plugins here
if has('nvim')

	"Java autocomplete
	Plugin 'artur-shaik/vim-javacomplete2'

endif

call vundle#end()	"finish delcarations of plugins

" start inplemtation of plugins

if !has('nvim')
	" turn on colour coded
	let g:color_coded_enabled = 1
	let g:color_coded_filetypes = ['c', 'cpp', 'objc', 'php', 'py']
endif

" make airline show.
let g:airline_powerline_fonts = 1
set laststatus=2 "make it show with no splits.

" start colour schemes

" my list of prefered colourschemes:
"
" hybrid
" monokai
" Tomorrow-Night
" molokai
" BlackSea
" SlateDark
" PaperColor
" solarized
" gruvbox
" dracula
syntax on
set t_Co=256 "265 colors in vim
set background=dark

let g:airline_theme="luna"
colorscheme base16-flat

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

" tmux naviagtor does this for us.
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" easymotion keymaps

nmap <leader>w <Plug>(easymotion-overwin-w)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)

set encoding=UTF-8

" set working dir for gvim
if has('gui_running')
	cd ~/Documents/projects/
	set guifont=Liberation\ Mono\ for\ Powerline\ 10
endif

