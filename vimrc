""""""""""""""
" VIM Config "
""""""""""""""

set langmenu=zh_CN.UTF-8
set helplang=cn
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=gb2312
set termencoding=utf-8

set statusline=文件名[%f%m%r%h%w];[格式=%{&ff}];[文件类型=%Y];[当前坐标=%l,%v][%p%%];时间[%{strftime(\"%d-%m\-\%H:%M\")}]

set sw=4
set ts=4
set et
set smarttab
set smartindent
set lbr
set fo+=mB
set sm
set selection=inclusive
set wildmenu
set mousemodel=popup

set bg=dark
syntax on
set t_Co=256
set cul
set cuc
set go=
autocmd InsertEnter * se cul
set ruler
set showcmd
set scrolloff=3

set laststatus=2
set nocompatible

set autoindent

set cindent
set tabstop=4       
set softtabstop=4
set shiftwidth=4

set expandtab
set smarttab
set number
set history=1000

set hlsearch
set incsearch


filetype on
filetype plugin on
filetype indent on
set viminfo+=!
set iskeyword+=_,$,@,%,#,-

nmap tt :%s/\t/    /g<CR>

if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
endif

set autoread

autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

set completeopt=preview,menu 

set clipboard+=unnamed

set autowrite

set magic
set guioptions-=T
set guioptions-=m

set foldmethod=indent     
set foldlevel=3 
set nocompatible
set noeb
set confirm

set nobackup
set noswapfile

set ignorecase
set linespace=0

set wildmenu
set backspace=2

set whichwrap+=<,>,h,l

set mouse=a
set selection=exclusive
set selectmode=mouse,key

set report=0

set fillchars=vert:\ ,stl:\ ,stlnc:\

set showmatch
set matchtime=1
set scrolloff=3

inoremap <C-k> <Up>

inoremap <C-j> <Down>

inoremap  <C-b> <Left>

inoremap <C-f> <Right>

inoremap <C-a> <Home>

inoremap <C-e> <End>

inoremap <C-d> <Del>

inoremap <C-g> <Backspace>

"filetype plugin on
