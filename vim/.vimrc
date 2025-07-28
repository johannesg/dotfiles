" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('win32')
  set langmenu=en_US.UTF-8    " sets the language of the menu (gvim)
  language English_United States 
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
"  
"  " Color schemes
"  " Plugin 'jnurmine/Zenburn'
"  " Plugin 'tomasr/molokai'
"  " Plugin 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'Lokaltog/vim-easymotion'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'ekalinin/Dockerfile.vim'

call plug#end()

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
  elseif has('mac')
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:12
    let g:airline_powerline_fonts = 1
  else
"    set guifont=DejaVu\ Sans\ Mono\ 10
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 11
    let g:airline_powerline_fonts = 1
  endif
  colorscheme monokai
elseif has('win32')
"  set t_Co=16
"  colorscheme hybrid
"  let g:airline_powerline_fonts = 0
else
  colorscheme monokai
  let g:airline_powerline_fonts = 0
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
  autocmd FileType yml setlocal ts=4 sts=4 sw=4 expandtab

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
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_working_path_mode = ''

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['eslint']

" Mappings
let mapleader=','

" Don't use Ex mode, use Q for formatting
map Q gq

noremap <C-Tab> gt
noremap <S-C-Tab> gT

noremap <C-Up> ddkP
noremap <C-Down> ddp
" nnoremap <leader>nt :NERDTreeToggle<CR>
" noremap <F6> :wa<CR>:make<CR>
" inoremap <F6> <Esc>:wa<CR>:make<CR>
" noremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" noremap <C-k><C-d> :ClangFormat<CR>
" inoremap <F4> <Esc>:e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Use CTRL-S for saving, also in Insert mode
" noremap <C-S> :update<CR>
" vnoremap <C-S> <C-C>:update<CR>
" inoremap <C-S> <C-O>:update<CR>
" inoremap <C-S> <Esc>:update<CR>

" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

nmap <leader>v :tabedit $MYVIMRC<CR>

"
" Use pt in unite grep source.
" let g:unite_source_grep_max_candidates = 200
" let g:unite_source_grep_command = 'pt'
" let g:unite_source_grep_default_opts = '--nogroup --nocolor'
" let g:unite_source_grep_recursive_opt = ''
" let g:unite_source_grep_encoding = 'utf-8'

"
" Use start insert by default.
      " \   'start_insert' : 1,
" call unite#custom#profile('default', 'context', {
"       \   'ignorecase'   : 1
"       \ })

" Unite
" let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
" let g:unite_source_history_yank_enable = 1

" nnoremap <leader>f  :<C-u>Unite file_rec/async -start-insert<CR>
" nnoremap <leader>b  :<C-u>Unite buffer<CR>
" nnoremap <leader>y  :<C-u>Unite history/yank<CR>
" nnoremap <leader>r  :<C-u>Unite register:abcdefq<CR>
" nnoremap <leader>g  :<C-u>Unite grep:.<CR>

" " VimFiler
" let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_ignore_pattern = ['^\.git$', '^\.svn$', 'node_modules', '^\.DS_Store$']
" let g:vimfiler_tree_opened_icon = '▾'
" let g:vimfiler_tree_closed_icon = '▸'

" call vimfiler#custom#profile('default', 'context', {
"       \   'explorer' : 1,
"       \   'safe' : 1
"       \ })

" nnoremap <leader>e  :<C-u>VimFilerExplorer<CR>
