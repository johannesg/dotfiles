if has('win32')
  set langmenu=en_US.UTF-8    " sets the language of the menu (gvim)
  language English_United States 
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'

Plugin 'jnurmine/Zenburn'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sickill/vim-monokai'
Plugin 'w0ng/vim-hybrid'

Plugin 'scrooloose/nerdtree.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-repeat'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'

if !has("win32")
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'rhysd/vim-clang-format'
"   Plugin 'edkolev/tmuxline.vim'
endif

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoi a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

" Colors
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
"set background=dark

"set ttimeoutlen=50

if has('gui_running')
  set guioptions-=T  " no toolbar
  "  colorscheme elflord
  set lines=60 columns=148 linespace=0
  if has('gui_win32')
    set guifont=Consolas:h11:cANSI

"    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
"    set guifont=Powerline_Consolas:h11:cANSI
"    set guifont=Inconsolata_for_Powerline:h11:cANSI
    let g:airline_powerline_fonts = 0
  else
"    set guifont=DejaVu\ Sans\ Mono\ 10
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
    let g:airline_powerline_fonts = 1
  endif
  colorscheme hybrid
elseif has('win32')
  set t_Co=16
  colorscheme hybrid
  let g:airline_powerline_fonts = 0
else
  colorscheme hybrid
  let g:airline_powerline_fonts = 1
endif

" allow backspacing over everything in insert mode

set nobackup    " do not keep a backup file, use versions instead
set number              " show line numbers
set hlsearch            "highlight all matching phrases   
set cursorline
"set cursorcolumn

set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


" Set default tabs to 4, spaces only
set ts=4 sts=4 sw=4 expandtab

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

  " Customisations based on house-style (arbitrary)
"  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
"  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
"  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
"
"  " Treat .rss files as XML
"  autocmd BufNewFile,BufRead *.rss setfiletype xml

  " Source the vimrc file after saving it
  "autocmd bufwritepost .vimrc source $MYVIMRC
endif


" Mappings
let mapleader=','

" Don't use Ex mode, use Q for formatting
map Q gq

noremap <C-Tab> gt
noremap <S-C-Tab> gT

noremap <C-Up> ddkP
noremap <C-Down> ddp
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>b :ls<CR>:buffer<Space>
noremap <F6> :wa<CR>:make<CR>
inoremap <F6> <Esc>:wa<CR>:make<CR>
noremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
inoremap <F4> <Esc>:e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
noremap <C-k><C-d> :ClangFormat<CR>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
"inoremap <C-S> <C-O>:update<CR>
inoremap <C-S> <Esc>:update<CR>

" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

nmap <leader>v :tabedit $MYVIMRC<CR>

