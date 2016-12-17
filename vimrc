""""""""""""""""""""""
"      Vundle        "
""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
    
    Plugin 'tpope/vim-fugitive'

    Plugin 'fatih/vim-go'
    Plugin 'AndrewRadev/splitjoin.vim'
    Plugin 'SirVer/ultisnips'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'majutsushi/tagbar'

    Plugin 'scrooloose/nerdtree'
    Plugin 'Xuyuanp/nerdtree-git-plugin'
    Plugin 'jistr/vim-nerdtree-tabs'

    Plugin 'dracula/vim'
call vundle#end()

filetype plugin indent on

""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
set nocompatible                " Enables us Vim specific features
set number                      " Show line numbers
set ruler                       " 右下角显示光标信息
"set backspace=2
set backspace=indent,eol,start  " Makes backspace key more powerful.
set encoding=utf-8              " Set default encoding to UTF-8
set laststatus=2                " Show status line always
set autoindent                  " Enabile Autoindent
set autowrite                   " Automatically save before :next, :make etc.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set wrapscan                    " Search around the file
set nocompatible                " Enables us Vim specific features
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set hidden                      " Buffer should still exist if window is closed
set history=50                  " 设置冒号命令和搜索命令历史列表长度

set expandtab                   " 输入tab自动转化为空格
set shiftwidth=4                " 设定回车自动缩进
set tabstop=4                   " 设定 tab 的位置
set softtabstop=4               " 设定编辑模式下tab的视在宽度

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard=unnamed
  set clipboard=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif

syntax on
color dracula


""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

" Set leader shortcut to a comma ','. By default it's the backslash
let mapleader = ","

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
map <C-j> :cnext<CR>
map <C-k> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

""""""""""""""""""""""
"      vim-go        "
""""""""""""""""""""""
" vim-go start ============================

" Show by default 4 spaces for a tab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1

let g:go_test_timeout = '10s'
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1
" let g:go_auto_type_info = 1
" let g:go_fmt_fail_silently = 1
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_list_type = "quickfix"

" :GoBuild and :GoTestCompile
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" :GoTest
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" :GoRun
autocmd FileType go nmap <leader>r  <Plug>(go-run)
" :GoDoc
autocmd FileType go nmap <Leader>d <Plug>(go-doc)
" :GoInfo
autocmd FileType go nmap <Leader>i <Plug>(go-info)
" :GoCoverageToggle
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
" :GoDef but opens in a vertical split
autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
" :GoDef but opens in a horizontal split
autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
" :GoAlternate  commands :A, :AV, :AS and :AT
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

" Nerdtree
map <C-n> :NERDTreeTabsToggle<CR>

let g:nerdtree_tabs_autofind=1
" open nerdtree automatic
" autocmd vimenter * NERDTree
" open nerdtree when open a folder
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" auto close when only nerdtree is open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
" vim-go end ============================
