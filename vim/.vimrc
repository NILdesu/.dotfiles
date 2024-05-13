" Vim defaults to `compatible` when selecting a vimrc with the command-line
" `-u` argument. Override this.
if &compatible
  set nocompatible
endif

" Enabling filetype support provides filetype-specific indenting,
" syntax highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on

" 'matchit.vim' is built-in so let's enable it!
" Hit '%' on 'if' ot jump to 'else'.
runtime macros/matchit.vim

" Folding begins here, press 'za' to open and close folds
" Core settings {{{
set termguicolors " true color terminal
set number        " set line numbers
set showcmd       " show commands at bottom
set autoindent    " minimal automatic indenting for any filetype
set cursorline    " highlight current line
set hidden        " possibility to have more than one unsaved buffers
set showmatch     " highlight matching braces
set wildmenu      " command line tab completion
set ruler         " shows the current line number at the bottom-right
set autoread      " reload files that have been edited outside of vim
set foldenable    " enable folding
set laststatus=2  " always show status line
set scrolloff=1   " always show 1 line above/below cursor
set mouse=a       " enable mouse use in all modes

" Make the escape key more responsive by decreasing the wait time for an
" escape sequence (e.g., arrow keys).
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" Create swap directory if it does not exist
if empty(glob($HOME . '/.vim/swap'))
  call mkdir($HOME . "/.vim/swap", "p", 0700)
endif

set directory=$HOME/.vim/swap  " Set swap directory

" Intuitive backspace behavior
set backspace=indent,eol,start

" Tabs to spaces
set expandtab     " expand tabs to spaces
set tabstop=2     " set tabs to 2 spaces
set softtabstop=2 " tab/backspace will insert/delete 2 spaces
set shiftwidth=2  " set autoindent width

" Persistent undo
" Create undo directory if it does not exist
if empty(glob($HOME . '/.vim/undo'))
  call mkdir($HOME . "/.vim/undo", "p", 0700)
endif

set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000

" Searching
set hlsearch   " highlight search terms
set ignorecase " case insensitive search
set smartcase  " switch to case sensitive if capitals used
set incsearch  " search as you type

" Set how whitespace is displayed
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.
"}}}
" Keybinds {{{
" Set Leader to space
map <Space> <Leader>

" Leader y,d,p copies and pastes to clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Completion without <C-x>
inoremap <C-o> <C-x><C-o>
inoremap <C-l> <C-x><C-l>

" New line without entering insert mode
nnoremap <silent> <Leader>o :<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "'[-1"<CR>
nnoremap <silent> <Leader>O :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "']+1"<CR>

" FZF keybindings
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>/ :Rg<Space>
nmap <Leader>* :Rg<Space><C-R><C-W><CR>

" When pasting, go to end of line
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Remove all trailing whitespace by hitting F5
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Map write file and remove whitespace to Leader w
nmap <Leader>w <F5>:w<CR>
"}}}
" Plugins {{{
" If vim-plug isn't installed, install it
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Make sure you use single quotes
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
call plug#end()

set omnifunc=ale#completion#OmniFunc
let g:gitgutter_git_executable='/usr/bin/git'

" Lightline
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
"}}}

colorscheme catppuccin_mocha

set modelines=1
" vim:foldmethod=marker:foldlevel=0
