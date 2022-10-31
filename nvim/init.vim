 "  ------------------------------------------------------------------------------
" VIM-PLUG
" ------------------------------------------------------------------------------

call plug#begin("~/.config/nvim/plugged")
Plug 'mbbill/undotree' " Save a full undo tree, not just a linear history
Plug 'machakann/vim-swap' " Swap the order of function arguments
Plug 'tpope/vim-surround' " Easily add or change parentheses around text
Plug 'lervag/vimtex' " Tools for editing LaTeX files
Plug 'Shougo/deoplete.nvim' " Autocomplete for latex
Plug 'SirVer/ultisnips' " Code snippets
" Plug 'ludovicchabant/vim-gutentags' " Regenerate tag files automatically
Plug 'tpope/vim-commentary' " Commands to comment out blocks of text
Plug 'Vimjas/vim-python-pep8-indent' " PEP8-compliant Python indentation
Plug 'dense-analysis/ale' " Asynchronous linter
Plug 'neovimhaskell/haskell-vim' " Haskell syntax highlighting and indentation
Plug 'tikhomirov/vim-glsl' " Syntax highlighting for GLSL
Plug 'rust-lang/rust.vim' " Rust formatting, syntax hightlighting, etc.
Plug 'psf/black' " Python formatting
call plug#end()

" ------------------------------------------------------------------------------
" MISC
" ------------------------------------------------------------------------------

" Syntax highlighting
syntax enable

" Omnicompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Save backups to ~/.nvim-tmp to avoid them cluttering the working directory
set backup
set backupdir=~/.nvim-bak
set directory=~/.nvim-bak
set writebackup
set fsync

" Wrap after 80 characters, unless in the middle of a word
" set wrap
"set tw=80

" Show line numbers relative to the current line
set number
set relativenumber 

" Make sure that the three lines above and below the cursor are always visible
set scrolloff=3

" Underline the current line
set cursorline

" Don't update the screen during a macro's execution, but only when it finishes
" (This makes macros run faster)
set lazyredraw

" Open new splits to the right of or below the current one
set splitbelow
set splitright

" ------------------------------------------------------------------------------
" INDENTATION
" ------------------------------------------------------------------------------

" Use 4 spaces for indentation, and replace tabs with spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Continue wrapped lines at the same indentation level
set breakindent

" Filetype-specific indentation
filetype on
filetype indent on

" ------------------------------------------------------------------------------
" SEARCHING
" ------------------------------------------------------------------------------

" Search dynamically as characters are entered
set incsearch

" If search starts with a capital, make search case-sensitive; otherwise, make
" it case-insensitive
set smartcase

" Show in realtime what changes will be made by s///
set inccommand=nosplit

" ------------------------------------------------------------------------------
"  KEY BINDINGS
" ------------------------------------------------------------------------------

" Use the spacebar to start ex commands, and free the colon mapping
" nnoremap <space> :
" nnoremap : <nop>

" Use right shift as the leader
map <space> <leader>

" Disable Ex mode
noremap Q <nop>

" Reload source file
nnoremap <leader>s :so ~/.config/nvim/init.vim<CR>

" Quickly clear highlighting
nnoremap <silent><leader>, :noh<CR>

" Reload buffer in place
nnoremap <leader>e :e<CR>

" ------------------------------------------------------------------------------
"  NAVIGATION
" ------------------------------------------------------------------------------

" Outside of insert mode, disable the arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" H to go to the first non-whitespace character of the current line, and L to
" the last
" U and J to jump half a page up or down respectively
nnoremap H ^
nnoremap L $
nnoremap U <C-u>
nnoremap J <C-d>

" Navigate up and down through wrapped lines based on what looks right, rather
" than moving through entire 'actual' lines
nnoremap j gj
nnoremap k gk

" ------------------------------------------------------------------------------
"  SPLITS
" ------------------------------------------------------------------------------

" Easier navigation through splits
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" Open new splits
nnoremap <leader>h :sp 
nnoremap <leader>v :vsp 

" ------------------------------------------------------------------------------
"  UNDO SETTINGS
" ------------------------------------------------------------------------------

set undofile
set undodir=$HOME/.nvim/undo
set undolevels=2500
set undoreload=10000

" Toggle undotree
nnoremap  <C-u> :UndotreeToggle<CR>

" ------------------------------------------------------------------------------
"  VIMTEX
" ------------------------------------------------------------------------------

" Compile LaTeX with latexmk multiple times
let g:vimtex_compiler_programme = "latexmk"
let g:Tex_MultipleCompileFormats = "pdf"

" Allows callbacks with neovim
let g:vimtex_compiler_progname = "nvr"

" View compiled PDFs with zathura
let g:vimtex_view_method = "zathura"

" Don't automatically forward search on starting the compilet
let g:vimtex_view_forward_search_on_start = 0

" Default TeX flavour
let g:tex_flavor = "latex"

let g:Tex_IgnoredWarnings = 
    \'Youre missing a field name'."\n".
    \'Overfull \hbox'."\n".
    \'Underfull'."\n".
    \'Overfull'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \'Double space found.'."\n"
let g:Tex_IgnoreLevel = 8

" Autocomplete with deoplete
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" Deoplete at startup
let g:deoplete#enable_at_startup = 1

" ------------------------------------------------------------------------------
" ALE
" ------------------------------------------------------------------------------

" Toggle ALE
nnoremap <leader>a :ALEToggle<CR>

" Expand error details
nnoremap <leader>d :ALEDetail<CR>

let g:ale_c_clangtidy_checks = ["-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling", "-clang-analyzer-security.insecureAPI.strcpy"]

let g:ale_rust_cargo_use_clippy = 1

" ------------------------------------------------------------------------------
" RUST
" ------------------------------------------------------------------------------

" Automatically run rustfmt on saving a buffer
let g:rustfmt_autosave = 1

" ------------------------------------------------------------------------------
" PYTHON
" ------------------------------------------------------------------------------

" Automatically run Black on saving a buffer
autocmd BufWritePre *.py execute ':Black'
