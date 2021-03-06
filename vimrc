if &term =~ "xterm-256color" || &term =~ "screen-256color"
    set t_Co=256
    "colorscheme inkpot
    "colorscheme pixelmuerto
    "colorscheme lyla
    "colorscheme mustang
    "colorscheme molokai
    "colorscheme myslate
    colorscheme wombat256dave
else
    colorscheme koehler
endif
set nocompatible
filetype off " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim "set the runtime path to include Vundle and initialize
au BufNewFile,BufRead *.Rmd let b:ft_rmd = 1
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"" Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'L9'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plugin 'Mizuchi/STL-Syntax'
"Plugin 'tomtom/tcomment_vim'
"Plugin 'majutsushi/tagbar'
Plugin 'gerw/vim-latex-suite'
""Plugin 'ivanov/vim-ipython'
"Plugin 'jalvesaq/Nvim-R' 
if !exists("b:ft_rmd") "If .Rmd file source modif slime.vim as rmarkdown.vim in ftplugin
  Plugin 'jpalardy/vim-slime'
endif
"Plugin 'epeli/slimux'
"Plugin 'ivan-krukov/vim-snakemake'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-rmarkdown'
"Plugin 'kana/vim-textobj-user'
call vundle#end() 
filetype plugin indent on     " required!
 
" Vim environment options
set linebreak
set shiftwidth=2
set tabstop=2
set expandtab
set history=800
set infercase " case inferred by default
set cursorline " highlight current line
set cursorcolumn " highlight the current column
set showmatch " show matching brackets
set showcmd " show the command being typed
set scrolloff=1 " Keep X lines (top/bottom) for scope
set report=0 " tell us when anything is changed via :...
set numberwidth=5
set hlsearch
set nu
set rnu
" au InsertEnter * :set nonu
" au InsertLeave * :set nu
au FocusLost * :set nornu
au FocusGained * :set rnu
autocmd BufNewFile,BufReadPost *.md
\ set filetype=markdown
set wrap
set splitright
set cpoptions=aABceFsmq
""             |||||||||
""             ||||||||+-- When joining lines, leave the cursor 
""             ||||||||     between joined lines
""             |||||||+-- When a new match is created (showmatch) 
""             |||||||     pause for .5
""             ||||||+-- Set buffer options when entering the 
""             ||||||     buffer
""             |||||+-- :write command updates current file name
""             ||||+-- Automatically add <CR> to the last line 
""             ||||     when using :@r
""             |||+-- Searching continues at the end of the match 
""             |||     at the cursor position
""             ||+-- A backslash has no special meaning in mappings
""             |+-- :write updates alternative file name
""             +-- :read updates alternative file name
set laststatus=2 " always show the status line
set ruler
" old status line
"set statusline=%t%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current 
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in 
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- modified flag in square brackets
"              +-- full path to file in the buffer
"
" Air-line status line
let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 1
syntax on " syntax highlighting on
set listchars-=trail:.            " don't show trailing spaces as '.' when typing
set exrc
set spell spelllang=en_us
set spellfile=vocab.en.utf-8.add

" YouCompleteMe options
let g:ycm_confirm_extra_conf = 0

" Below for the b:blah see
" http://stackoverflow.com/questions/15685729/vim-what-is-the-difference-between-let-g-let-b-etc
let b:cwd = expand('%:p:h')
" backup dir and files
let b:vimbup = b:cwd . '/.vimbup'
if !isdirectory(b:vimbup)
  execute 'silent !mkdir ' . b:vimbup . '> /dev/null 2>&1'
endif
execute 'set backupdir=' . b:vimbup
set backup " make backup files

" saving undos files in a dir
let b:vimundo = b:cwd . '/.vimundo'
if !isdirectory(b:vimundo)
  execute 'silent !mkdir' . b:vimundo . '> /dev/null 2>&1'
endif
set undodir=.vimundo
set undofile " save undos in files

" check if there are more local settings
let b:cwd=expand("%:p:h")
let b:vimlocal=b:cwd."/.local.vimrc"
if (filereadable(b:vimlocal))
  execute "source ".b:vimlocal
endif

" Enable copy-paste from tmux
set clipboard=unnamed

" Practical vim
set hidden

" vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_python_ipython = 1

" slimux
let g:slimux_R_keybindings = 1

" Folding
set foldmethod=manual

" Folding functions for Rnw files
" default one (folds text)
function! GetTextFold(lnum)
  if a:lnum == 1 || getline(a:lnum) =~ '^@$'
    return '>1'
  elseif a:lnum == line('$') || getline(a:lnum) =~ '<<.*>>='
    return '<1'
  endif
  return '='
endfunction

" switch to this one to fold code
function! GetCodeFold(lnum)
  if getline(a:lnum) =~ '<<.*>>='
    return '>1'
  elseif getline(a:lnum) =~ '^@$'
    return '<1'
  endif
  return '='
endfunction

" Folding for Rnw files
augroup NonDefaultFoldMethod
    autocmd!
    autocmd BufNewFile,BufRead *.Rnw setlocal
    \ foldmethod=expr
    \ foldexpr=GetTextFold(v:lnum)
    \ foldtext=getline(v:foldend)
augroup end

" Snakemake
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.rules set syntax=snakemake
au BufNewFile,BufRead *.snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake

" For knitr and rmarkdown
"call textobj#user#plugin('rmd', {
"\   'code': {
"\     'pattern': ['```{r.*}', '^```$'],
"\     'select-a': 'a`',
"\     'select-i': 'i`',
"\   },
"\ })

"au BufNewFile,BufRead *.Rmd let g:slime_R_Rmd = 1 |
"      \ nmap <c-c><c-v> vi` <Plug>SlimeRegionSend

