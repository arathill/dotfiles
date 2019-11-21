" -------------------------------------------------------------------------------------
"
" Personal VIM configuration - Still a bit messy...
" Author: arathill <git@arturkunasz.com>
" Version: 0.1.0
" Comment: My .vimrc after ~one month~ ~three months~ almost year of using Vim. 
" Mostly based on some .vimrc found on the web. Still a bit messy,
" but quite comfortable at the moment. Used with Neovim.
"
" -------------------------------------------------------------------------------------

syntax on

" -------------------------------------------------------------------------------------
" 1. GENERAL SETTINGS
" -------------------------------------------------------------------------------------
set nocompatible
set hidden
set backspace=indent,eol,start
set ruler
set number
set relativenumber
set showcmd
set incsearch
set hlsearch
set mouse=a
set showmatch
set ignorecase
set smartcase
set nobackup
set noswapfile
set title titlestring+=Neovim\ -\ %{substitute(getcwd(),\ '/home/arathill/Projekty/',\ '',\ '')}
set clipboard+=unnamedplus
set guioptions=
set lazyredraw
set nostartofline
set path+=**

" Set tab size
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround

" Set wrap
set wrap
set linebreak
set breakindent

" Show white spaces
set list
set listchars=tab:·\ ,trail:∙,nbsp:•

" Keep cursor in the middle
set scrolloff=15

" Theme settings
set laststatus=2
set termguicolors
set background=dark

" Cursor in TTY
if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
endif

if exists('$TMUX')
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
endif

filetype off

" -------------------------------------------------------------------------------------
" 2. Plugins
" -------------------------------------------------------------------------------------

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'mhinz/vim-startify'
Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'xolox/vim-misc'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'StanAngeloff/php.vim'
Plugin 'captbaritone/better-indent-support-for-php-with-html'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'Raimondi/delimitMate'
Plugin 'flazz/vim-colorschemes'
Plugin 'othree/html5.vim'
Plugin 'eshion/vim-sync'
Plugin 'mattn/emmet-vim'
Plugin 'ap/vim-css-color'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'terryma/vim-multiple-cursors'
Plugin 'vimwiki/vimwiki'
"Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ryanoasis/vim-devicons'
"Plugin 'junegunn/limelight.vim'
Plugin 'ervandew/supertab'

call vundle#end()
filetype plugin indent on

" -------------------------------------------------------------------------------------
" 3. Plugins settings
" -------------------------------------------------------------------------------------

" Plugin: Startify
let g:startify_list_order = [['   Aktualne projekty'], 'commands', ['   Ostatnio otwierane pliki'], 'dir', ['   Zakładki'], 'bookmarks']
let g:startify_change_to_dir = 0
let g:startify_enable_special = 0
let g:startify_session_dir = '~/.vim/session'
let g:startify_custom_header = ['   Startify / Neovim', '   » ' . getcwd()]
let g:startify_bookmarks = [ {'c': '~/.vimrc'} ]

if filereadable(expand("~/.vim/projects"))
	source ~/.vim/projects
	let g:startify_commands = projects
endif

" Plugin: CtrlP
let g:ctrlp_working_path_mode = 0

" Plugin: Airline
let g:airline_powerline_fonts = 1
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let airline#extensions#syntastic#error_symbol = 'E:'
let airline#extensions#syntastic#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#syntastic#warning_symbol = 'W:'
let airline#extensions#syntastic#stl_format_err = '%W{[%w(#%fw)]}'
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" Plugin: Limelight
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = '#777777'
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Plugin: NERD Tree
let g:nerdtree_tabs_open_on_console_startup = 1
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:WebDevIconsNerdTreeGitPluginForceVAlign=0
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let NERDTreeDirArrowExpandable = " "
let NERDTreeDirArrowCollapsible = " "

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg)
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' guibg='. a:bg .' guifg='. a:fg .' guibg='. a:bg .' guifg='. a:fg
endfunction

call NERDTreeHighlightFile('php', '#889999', 'none')
call NERDTreeHighlightFile('html', '#faaadd', 'none')
call NERDTreeHighlightFile('css', '#bbdd88', 'none')
call NERDTreeHighlightFile('js', '#aa99bb', 'none')

augroup nerdtreehidecwd
	autocmd!
	autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end

" Plugin: Syntastic
let g:syntastic_error_symbol = '×'
let g:syntastic_warning_symbol = "▲"

" Plugin: Easytags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" Plugin: Tagbar
let g:tagbar_autoclose=1
let g:tagbar_autofocus = 0
let g:tagbar_compact = 1
let g:tagbar_type_php  = {
			\ 'ctagstype' : 'php',
			\ 'kinds'     : [
			\ 'i:interfaces',
			\ 'c:classes',
			\ 'd:constant definitions',
			\ 'f:functions',
			\ 'j:javascript functions:1'
			\ ]
			\ }

" Plugin: GIT
hi clear SignColumn
let g:airline#extensions#hunks#non_zero_only = 1

" Plugin: Delimitemate
let delimitMate_expand_cr = 1
augroup mydelimitMate
	au!
	au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
	au FileType tex let b:delimitMate_quotes = ""
	au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
	au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" -------------------------------------------------------------------------------------
" 4. Colorscheme options
" -------------------------------------------------------------------------------------

" AirlineThemes: lucius Jellybeans Hybrid Minimalist
" Colorschemes: apprentice blame vilight office-light nefertiti hybrid

let g:airline_theme='lucius'
colorscheme nefertiti

hi EndOfBuffer ctermfg=236 guifg=#1c1c1c
hi NonText ctermbg=NONE ctermfg=236 guibg=NONE guifg=#303030 cterm=NONE gui=NONE
hi Normal guibg=NONE ctermbg=NONE
hi VertSplit guibg=NONE

if has("gui_running")
	let g:airline_theme='lucius'
	set guifont=Knack\ Nerd\ Font:h12
	set linespace=5
	colorscheme office-light
	hi EndOfBuffer ctermfg=NONE guifg=#ffffff
	hi NonText ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE cterm=NONE gui=NONE
endif

" -------------------------------------------------------------------------------------
" 5. Keys mapping
" -------------------------------------------------------------------------------------
" Auto upload on save
"autocmd BufWritePost * :call SyncUploadFile()

nnoremap <silent> <leader>q :bp<cr>:bd #<cr>
nnoremap <silent> <Left>		:call FindBuffer('bprevious')<CR>
nnoremap <silent> <Right>	:call FindBuffer('bnext')<CR>
nnoremap <silent> J :call FindBuffer('bprevious')<CR>
nnoremap <silent> K	:call FindBuffer('bnext')<CR>
nnoremap <Tab>   <c-W>w
nnoremap <S-Tab> <c-W>W

map <silent> k gk
map <silent> j gj

" Override after some system-wide Karabiner Elements modifications
noremap <silent> <PageUp> <C-u>
noremap <silent> <PageDown> <C-d>
inoremap <silent> <PageUp> <nop>
inoremap <silent> <PageDown> <nop>

" Learn how to use keys more efficient

" ... and do not lose text in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Disable CtrlP mappings to override it with FindBuffer function
let g:ctrlp_map = ''
nnoremap <C-p> :call FindBuffer('CtrlP')<CR>
nnoremap <C-b> :call FindBuffer('CtrlPBuffer')<CR>

noremap <silent> <leader>s :call asyncrun#quickfix_toggle(8)<CR>
noremap <silent> <leader>u :call SyncUploadFile()<CR>
noremap <silent> <leader>d :call SyncDownloadFile()<CR>
noremap <silent> <leader>x :AsyncStop
nmap <silent> <leader>c :nohlsearch<CR>

nmap <silent> <leader>b :TagbarToggle<CR>
nmap <silent> <leader>t :NERDTreeToggle<CR>

" edit/reload the vimrc file
nmap <silent> <leader>ev :call FindBuffer('e ~/.vimrc')<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>
nmap <silent> <leader>p :call FindBuffer('Startify')<CR>

" List contents of all registers (that typically contain pasteable text)
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

" semicolon trick
nnoremap ; :

" Focus mode
nnoremap <silent> <leader>fm :call FocusModeOn()<cr>
nnoremap <silent> <leader>nm :call FocusModeOff()<cr>

" -------------------------------------------------------------------------------------
" 6. Functions
" -------------------------------------------------------------------------------------

function! PhpSyntaxOverride()
	hi! link phpDocTags phpDefine
	hi! link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
	autocmd!
	autocmd FileType php call PhpSyntaxOverride()
augroup END


" FocusMode
function! FocusModeOn()
	exec 'only'
	set laststatus=0
	set showtabline=0
	set numberwidth=10
	set foldcolumn=2
	set noruler
	set norelativenumber
	set nonumber
	set nobreakindent
	set nolist
	set spell spelllang=pl
	hi FoldColumn ctermbg=none guibg=none
	hi VertSplit guibg=none
	hi LineNr ctermfg=0 ctermbg=none guibg=none
endfunc
function! FocusModeOff()
	exec 'only'
	set laststatus=2
	set showtabline=2
	set numberwidth=4
	set foldcolumn=0
	set ruler
	set relativenumber
	set number
	set breakindent
	set nospell
	set list
	execute 'colorscheme ' . g:colors_name
	hi Normal guibg=NONE ctermbg=NONE
	hi EndOfBuffer ctermfg=236 guifg=#1c1c1c
	let g:airline#extensions#tabline#enabled = 1
	TagbarOpen
	NERDTreeToggle
endfunc

" Switch to writeable buffer and exec
function! FindBuffer(command)
	let c = 0
	let current = winnr()
	let name = expand('%:t')
	let wincount = winnr('$')

	if name == '__Tagbar__.1' || a:command == 'Startify'
		exec "normal 1\<C-W>\<C-w>"
	endif

	" Don't open it here if current buffer is not writable (e.g. NERDTree)
	while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
		exec 'wincmd w'
		let c = c + 1
	endwhile
	exec a:command

	if name == '__Tagbar__.1' || a:command == 'Startify'
		exec "normal \<C-W>" . current . "w"
	endif
endfunction

" Switch working directory and update NERDTree
function! SwitchWorkspace(projectpath)
	exec 'NERDTree ' a:projectpath
	exec 'cd ' a:projectpath
	let g:startify_custom_header = ['   Startify / Neovim', '   » ' . getcwd()]
	call FindBuffer('Startify')
endfunction
