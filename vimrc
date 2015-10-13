" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('win32')
  set langmenu=en_US.UTF-8    " sets the language of the menu (gvim)
  language English_United States 
endif


"NeoBundle Scripts-----------------------------"
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'tpope/vim-sensible'

" Color schemes
" Plugin 'jnurmine/Zenburn'
" Plugin 'tomasr/molokai'
" Plugin 'altercation/vim-colors-solarized'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'w0ng/vim-hybrid'

NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'bling/vim-airline'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'gregsexton/gitv'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'shime/vim-livedown'
NeoBundle 'nginx.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'

" snippets
if has('python')
    NeoBundle 'SirVer/ultisnips'
    NeoBundle 'honza/vim-snippets'
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger = '<c-j>'
    " let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<c-j>'
    " let g:UltiSnipsJumpBackwardTrigger = '<c-z>'

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit='vertical'
endif

" javascript & htmn
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'maksimr/vim-jsbeautify'
let g:jsx_ext_required = 0

" go
NeoBundle 'fatih/vim-go'

" rust
" NeoBundle 'rust-lang/rust.vim'
" NeoBundle 'phildawes/racer'

NeoBundle 'Shougo/neocomplete.vim'
if !has("win32")
    " NeoBundle 'Valloric/YouCompleteMe'
"    NeoBundle 'rhysd/vim-clang-format'
"   NeoBundle 'edkolev/tmuxline.vim'
endif

call neobundle#end()
filetype plugin indent on    " required

" If there are uninstalled bundles found on startup,"
" this will conveniently prompt you to install them."
NeoBundleCheck"
"End NeoBundle Scripts-------------------------"

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
  colorscheme monokai
elseif has('win32')
  set t_Co=16
  colorscheme hybrid
  let g:airline_powerline_fonts = 0
else
  colorscheme monokai
  let g:airline_powerline_fonts = 1
endif

" allow backspacing over everything in insert mode

set nobackup    " do not keep a backup file, use versions instead
set number              " show line numbers
set hlsearch            "highlight all matching phrases   
set cursorline
"set cursorcolumn
set backupcopy=yes

set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


" Set default tabs to 4, spaces only
set ts=2 sts=2 sw=2 expandtab

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

" Ctrl P
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_working_path_mode = ''

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

" Mappings
let mapleader=','

" Don't use Ex mode, use Q for formatting
map Q gq

noremap <C-Tab> gt
noremap <S-C-Tab> gT

noremap <C-Up> ddkP
noremap <C-Down> ddp
" nnoremap <leader>nt :NERDTreeToggle<CR>
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

" Unite
let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
let g:unite_source_history_yank_enable = 1
"
" Use ag in unite grep source.
let g:unite_source_grep_max_candidates = 200
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --vimgrep --hidden --ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

nnoremap <leader>f  :<C-u>Unite file_rec/async<CR>
nnoremap <leader>b  :<C-u>Unite buffer<CR>
nnoremap <leader>y  :<C-u>Unite history/yank<CR>
nnoremap <leader>r  :<C-u>Unite register:abcdefq<CR>
nnoremap <leader>g  :<C-u>Unite grep:.<CR>

" VimFiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'

call vimfiler#custom#profile('default', 'context', {
      \   'explorer' : 1,
      \   'safe' : 1
      \ })

nnoremap <leader>e  :<C-u>VimFilerExplorer<CR>
