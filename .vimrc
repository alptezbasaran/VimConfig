" Modified vimrc
" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'fisadev/fisa-vim-config'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'sukima/xmledit'

    if iCanHazVundle == 0
        echo "Installing Vundles, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif


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

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif
set history=50    " keep 50 lines of command line history
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set incsearch   " do incremental searching

set nowrap " disables word wrap -> continuous lines

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Map NERDtree
map <C-e> :NERDTree

" In an xterm the mouse should work quite well, thus enable it.
" set mouse=a

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType tex setlocal textwidth=110
  autocmd FileType tex setlocal formatoptions+=t
  autocmd FileType tex setlocal spell spelllang=en_us

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis

"au BufWinLeave *.py mkview
"au BufWinEnter *.py silent loadview

" from amix.dk/vim/vimrc.html
" search case mods
set ignorecase
set smartcase
" error mods
set noerrorbells
set novisualbell
set t_vb=
set tm=2000
set title " allows vim to set window title

" colors and fonts
" colorscheme sweyla988775 " in ~/.vim/color, sweyla.com/themes/seed/988775
" colorscheme sweyla947829 " in ~/.vim/color, sweyla.com/themes/seed/988775
syntax enable
" set background=dark
" highlight Comment ctermfg=darkgreen

set mouse=nicr

" Arrange tabs
function! SetStandard()
  set expandtab
  set autoindent
  set smartindent
  set smarttab
  set softtabstop=2
  set shiftwidth=2
  set tabstop=2
endfunction
command! -bar SetStandard call SetStandard()
au FileType python,py call SetStandard()

" python stuff -> move? to ~/.vim/after/ftplugin
"let python_highlight_all = 1
"let g:python_syntax_fold = 1
au FileType python,py let python_highlight_all = 1
au FileType python,py let g:python_syntax_fold = 1

au FileType python syn keyword pythonDecorator True None False self
"trailing whitespace removal
autocmd BufWritePre * :%s/\s\+$//e
" autocmd FileType c,cpp,python,xml autocmd BufWritePre *py :%s/\s\+$//e

" xml, set new tabstop
filetype plugin indent on
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" pretty xml
au FileType xml command PrettyXML %!xmllint --format %

au FileType xml let xml_highlight_all=1
au FileType xml let g:xml_syntax_folding=1
au Filetype c,cpp,xml,html,python,py setlocal foldmethod=syntax
au BufReadPost *.xml set syntax=xml
au Filetype moose_fw setlocal foldmethod=syntax
" au Filetype python,py setlocal foldmethod=indent
" au Filetype c,cpp,xml,html,python normal zR
" au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif

" additional for latex plugin (vim-latex)
set grepprg=grep\ -nh\ $*
let g:tex_flavor='latex'

" CSV type
au! BufNewFile,BufRead *.csv setf csv

" Show line numbers
set number
" Show statusline
set laststatus=2

" Case-insensitive search
set ignorecase

" Highlight search results

