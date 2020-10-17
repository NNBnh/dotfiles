""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load plugins
call plug#begin('~/.local/share/nvim/plugged')
	" Defaults
	Plug 'tpope/vim-sensible'                    "Defaults everyone can agree on
	Plug 'editorconfig/editorconfig-vim'                           "EditorConfig

	" UI
	Plug 'srcery-colors/srcery-vim'                                 "Colorscheme
	Plug 'vim-airline/vim-airline'                                  "Status line
	Plug 'scrooloose/syntastic'                                         "Syntaxs
	Plug 'norcalli/nvim-colorizer.lua'                          "Color hex codes
	Plug 'tmhedberg/simpylfold'                                  "Folding Python
	Plug 'google/vim-searchindex'                              "Number in search
	""Plug 'airblade/vim-gitgutter'                                        "Gits

	" Edits
		" Inserts
		""""Plug 'neoclide/coc.nvim', {'branch': 'release'}          "Completion
		""""Plug 'sirver/ultisnips'                                       "Snips

		" Movements
		Plug 'easymotion/vim-easymotion'                                   "Goto

		" Selects
		Plug 'terryma/vim-multiple-cursors'                    "Multiple cursors

		" Comment
		Plug 'scrooloose/nerdcommenter'                                 "Comment

		" Grammar checker
		""Plug 'dpelle/vim-languagetool'                        "Grammar checker

		" Files
		""Plug 'scrooloose/nerdtree', {'on':'NERDTreeToggle'}       "Files panel
		""Plug 'xuyuanp/nerdtree-git-plugin', {'on':'NERDTreeToggle'}"Gits panel
		""Plug 'tpope/vim-fugitive'                                     "Do Gits

	" Dependencies
	Plug 'ryanoasis/vim-devicons'                                          "Icon
call plug#end()

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Enable filetype plugins
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set colorscheme
let g:srcery_transparent_background = 1
let g:srcery_italic = 1
colorscheme srcery

" Set the window’s title, reflecting the file currently being edited
set title

" Turn on the line numbers
set number
set relativenumber

" The number of screen lines to keep above and below the cursor
set scrolloff=7

" The number of screen columns to keep to the left and right of the cursor
set sidescrolloff=3

" No wrap lines
set nowrap

" Always try to show a paragraph’s last line
set display+=lastline

" Turn on the Wild menu
set wildmenu

" Status line
autocmd VimEnter * AirlineToggle
autocmd VimEnter * set laststatus=0
autocmd User AirlineToggledOn set noshowmode
autocmd User AirlineToggledOff set laststatus=0
autocmd User AirlineToggledOff set showmode
set rulerformat=%l:%v\ \/\ %L
let g:airline#extensions#default#layout = [
	\ [ 'a', 'b', 'c' ],
	\ [ 'x', 'error', 'warning', 'z' ]
	\ ]
let g:airline_section_z = '%l:%v / %L'

" Enable syntax highlighting
syntax enable
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Color hex codes
set termguicolors
lua require 'colorizer'.setup(nil, { names = false; })


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight search results
set hlsearch

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Makes search act like search in modern browsers
set incsearch


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and backspace """"""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set free-range cursor in V-Block mode
set virtualedit=onemore

" Interpret octal as decimal when incrementing numbers
set nrformats-=octal

" 1 tab == 4 spaces
set noet ci pi sts=0 sw=4 ts=4

" Auto and smart tab
set autoindent
set smarttab

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Configure so it acts as it should act
set whichwrap+=<,>,h,l,[,]
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set formatoptions+=j
setglobal tags-=./tags tags-=./tags; tags^=./tags;


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't redraw while executing macros (good performance config)
set lazyredraw

" Limit the files searched for auto-completes
set complete-=i

" Display a confirmation dialog when closing an unsaved file
set confirm

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" History
set history=1000

" Maximum number of tab pages that can be opened from the command line
set tabpagemax=50

" Options
set sessionoptions-=options
set viewoptions-=options

" Remove trailing whitespace when saveing
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybinding """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unmap keys
let g:no_plugin_maps = 1
let g:multi_cursor_use_default_mapping = 0

map ` <Nop>
map ~ <Nop>
map ! <Nop>
map @ <Nop>
map # <Nop>
map $ <Nop>
map % <Nop>
map ^ <Nop>
map & <Nop>
map * <Nop>
map ( <Nop>
map ) <Nop>
map - <Nop>
map _ <Nop>
map <C--> <Nop>
map = <Nop>
map + <Nop>
map <C-=> <Nop>
map q <Nop>
map Q <Nop>
map <C-q> <Nop>
map w <Nop>
map W <Nop>
map <C-w> <Nop>
map e <Nop>
map E <Nop>
map <C-e> <Nop>
map r <Nop>
map R <Nop>
map <C-r> <Nop>
map t <Nop>
map T <Nop>
map <C-t> <Nop>
map y <Nop>
map Y <Nop>
map <C-y> <Nop>
map u <Nop>
map U <Nop>
map <C-u> <Nop>
map i <Nop>
map I <Nop>
map <C-i> <Nop>
map o <Nop>
map O <Nop>
map <C-o> <Nop>
map p <Nop>
map P <Nop>
map <C-p> <Nop>
map [ <Nop>
map { <Nop>
map <C-[> <Nop>
map ] <Nop>
map } <Nop>
map <C-]> <Nop>
map a <Nop>
map A <Nop>
map <C-a> <Nop>
map s <Nop>
map S <Nop>
map <C-s> <Nop>
map d <Nop>
map D <Nop>
map <C-d> <Nop>
map f <Nop>
map F <Nop>
map <C-f> <Nop>
map g <Nop>
map G <Nop>
map <C-g> <Nop>
map h <Nop>
map H <Nop>
map <C-h> <Nop>
map j <Nop>
map J <Nop>
map <C-j> <Nop>
map k <Nop>
map K <Nop>
map <C-k> <Nop>
map l <Nop>
map L <Nop>
map <C-l> <Nop>
map ; <Nop>
map : <Nop>
map <C-;> <Nop>
map ' <Nop>
map " <Nop>
map <C-'> <Nop>
map z <Nop>
map Z <Nop>
map <C-z> <Nop>
map x <Nop>
map X <Nop>
map <C-x> <Nop>
map c <Nop>
map C <Nop>
map <C-c> <Nop>
map v <Nop>
map V <Nop>
map <C-v> <Nop>
map b <Nop>
map B <Nop>
map <C-b> <Nop>
map n <Nop>
map N <Nop>
map <C-n> <Nop>
map m <Nop>
map M <Nop>
map <C-m> <Nop>
map , <Nop>
map < <Nop>
map <C-,> <Nop>
map . <Nop>
map > <Nop>
map <C-.> <Nop>
map / <Nop>
map ? <Nop>
map <C-/> <Nop>
map <Bslash> <Nop>
map <Bar> <Nop>
map <Space> <Nop>
"map <Tab> <Nop>
"map <CR> <Nop>

" Prefix
let mapleader = "r"
let maplocalleader = "R"

" Nava Mode
	" Modes
	noremap / :
	noremap ? :!
	noremap ; :
	noremap : :!
	noremap <Space> <Insert>
	noremap <Leader><Space> <Esc>R
	noremap s v
	noremap S <C-v>

	" Movements
	noremap i <Up>
	noremap I {
	noremap <C-i> <C-u>
	noremap k <Down>
	noremap K }
	noremap <C-k> <C-d>
	noremap j <Left>
	noremap J b
	noremap l <Right>
	noremap L e<Right>

		" Advance
		noremap u B
		noremap <C-u> <PageUp>
		noremap o E<Right>
		noremap <C-o> <PageDown>
		noremap n ^
		noremap nn <Home>
		noremap N gg
		noremap m <End>
		noremap M G
		noremap <Tab> n
		noremap <S-Tab> N

		" Gotos
		map h <Plug>(easymotion-overwin-f)
		noremap H g
		noremap H, `
		noremap H< '

		" Bookmarks
		noremap <Leader>, '
		noremap <Leader>. m

	" Selects
	let g:multi_cursor_start_word_key      = 'a'
	let g:multi_cursor_select_all_word_key = 'A'
	let g:multi_cursor_start_key           = '<Leader>a'
	let g:multi_cursor_select_all_key      = '<Leader>A'
	let g:multi_cursor_next_key            = 'a'
	let g:multi_cursor_prev_key            = 'ga'
	let g:multi_cursor_skip_key            = 'g<Space>'
	let g:multi_cursor_quit_key            = '<Esc>'

	" Search & replace
	noremap g /
	noremap G :%s///gc<Left><Left><Left><Left>
	noremap <Leader>g *

	" Edits
		" Inserts
		noremap w <Insert>_<Esc>r
		noremap p o
		noremap P O

		" Moves
		noremap bj <<
		noremap bl >>

		" Deletes
		noremap <Del> "_X
		noremap <BS> "_X
		noremap e "_X
		noremap E "_d
		noremap Ee "_D
		noremap EE "_dd

		" Clipboards
		noremap c "+y
		noremap cc "+yy
		noremap C y
		noremap d "+d
		noremap dd "+dd
		noremap D d
		noremap DD dd
		noremap x "+d
		noremap xx "+dd
		noremap X d
		noremap XX dd
		noremap v "+gP
		noremap V gP
		noremap 0 "

		" Undo
		noremap f <Undo>
		noremap z <Undo>
		noremap F <C-r>
		noremap Z <C-r>

		" Hex
		noremap - <C-x>
		noremap _ <C-x>
		noremap = <C-a>
		noremap + <C-a>

		" Comment & Fold
		noremap ' z
		map " <plug>(NERDCommenterToggle)

	" Macros
	noremap <Leader>c q
	noremap <Leader>v @

	" Infos
	noremap q :AirlineToggle<CR>

	" Files
	noremap , :e
	noremap . :w<CR>
	noremap > :w %:h/

" Alt
	" Nava
	map <M-`> `
	map <M-~> ~
	map <M-!> !
	map <M-@> @
	map <M-#> #
	map <M-$> $
	map <M-%> %
	map <M-^> ^
	map <M-&> &
	map <M-*> *
	map <M-(> (
	map <M-)> )
	map <M--> -
	map <M-_> _
	map <M-=> =
	map <M-+> +
	map <M-q> q
	map <M-Q> Q
	map <M-w> w
	map <M-W> W
	map <M-e> e
	map <M-E> E
	map <M-r> r
	map <M-R> R
	map <M-t> t
	map <M-T> T
	map <M-y> y
	map <M-Y> Y
	map <M-u> u
	map <M-U> U
	map <M-i> i
	map <M-I> I
	map <M-o> o
	map <M-O> O
	map <M-p> p
	map <M-P> P
	map <M-[> [
	map <M-{> {
	map <M-]> ]
	map <M-}> }
	map <M-a> a
	map <M-A> A
	map <M-s> s
	map <M-S> S
	map <M-d> d
	map <M-D> D
	map <M-f> f
	map <M-F> F
	map <M-g> g
	map <M-G> G
	map <M-h> h
	map <M-H> H
	map <M-j> j
	map <M-J> J
	map <M-k> k
	map <M-K> K
	map <M-l> l
	map <M-L> L
	map <M-;> ;
	map <M-'> '
	map <M-"> "
	map <M-z> z
	map <M-Z> Z
	map <M-x> x
	map <M-X> X
	map <M-c> c
	map <M-C> C
	map <M-v> v
	map <M-V> V
	map <M-b> b
	map <M-B> B
	map <M-n> n
	map <M-N> N
	map <M-m> m
	map <M-M> M
	map <M-,> ,
	map <M-<> <
	map <M-.> .
	map <M->> >
	map <M-/> /
	map <M-?> ?
	map <M-Bslash> <Bslash>
	map <M-Bar> <Bar>

	" Viet
	imap <M-`> <C-o>`
	imap <M-~> <C-o>~
	imap <M-!> <C-o>!
	imap <M-@> <C-o>@
	imap <M-#> <C-o>#
	imap <M-$> <C-o>$
	imap <M-%> <C-o>%
	imap <M-^> <C-o>^
	imap <M-&> <C-o>&
	imap <M-*> <C-o>*
	imap <M-(> <C-o>(
	imap <M-)> <C-o>)
	imap <M--> <C-o>-
	imap <M-_> <C-o>_
	imap <M-=> <C-o>=
	imap <M-+> <C-o>+
	imap <M-q> <C-o>q
	imap <M-Q> <C-o>Q
	imap <M-w> <C-o>w
	imap <M-W> <C-o>W
	imap <M-e> <C-o>e
	imap <M-E> <C-o>E
	imap <M-r> <C-o>r
	imap <M-R> <C-o>R
	imap <M-t> <C-o>t
	imap <M-T> <C-o>T
	imap <M-y> <C-o>y
	imap <M-Y> <C-o>Y
	imap <M-u> <C-o>u
	imap <M-U> <C-o>U
	imap <M-i> <C-o>i
	imap <M-I> <C-o>I
	imap <M-o> <C-o>o
	imap <M-O> <C-o>O
	imap <M-p> <C-o>p
	imap <M-P> <C-o>P
	imap <M-[> <C-o>[
	imap <M-{> <C-o>{
	imap <M-]> <C-o>]
	imap <M-}> <C-o>}
	imap <M-a> <C-o>a
	imap <M-A> <C-o>A
	imap <M-s> <C-o>s
	imap <M-S> <C-o>S
	imap <M-d> <C-o>d
	imap <M-D> <C-o>D
	imap <M-f> <C-o>f
	imap <M-F> <C-o>F
	imap <M-g> <C-o>g
	imap <M-G> <C-o>G
	imap <M-h> <C-o>h
	imap <M-H> <C-o>H
	imap <M-j> <C-o>j
	imap <M-J> <C-o>J
	imap <M-k> <C-o>k
	imap <M-K> <C-o>K
	imap <M-l> <C-o>l
	imap <M-L> <C-o>L
	imap <M-;> <C-o>;
	imap <M-'> <C-o>'
	imap <M-"> <C-o>"
	imap <M-z> <C-o>z
	imap <M-Z> <C-o>Z
	imap <M-x> <C-o>x
	imap <M-X> <C-o>X
	imap <M-c> <C-o>c
	imap <M-C> <C-o>C
	imap <M-v> <C-o>v
	imap <M-V> <C-o>V
	imap <M-b> <C-o>b
	imap <M-B> <C-o>B
	imap <M-n> <C-o>n
	imap <M-N> <C-o>N
	imap <M-m> <C-o>m
	imap <M-M> <C-o>M
	imap <M-,> <C-o>,
	imap <M-<> <C-o><
	imap <M-.> <C-o>.
	imap <M->> <C-o>>
	imap <M-/> <C-o>/
	imap <M-?> <C-o>?
	imap <M-Bslash> <C-o><Nop>
	imap <M-Bar> <C-o><Nop>

" Viet mode
	" Movements
	noremap! <M-i> <Up>
	noremap! <M-k> <Down>
	noremap! <M-j> <Left>
	noremap! <M-S-j> <S-Left>
	noremap! <M-l> <Right>
	cnoremap <M-S-l> <S-Right>

		" Advance
		cnoremap <M-u> <S-Left>
		cnoremap <M-o> <S-Right>
		cnoremap <M-n> <Home>
		noremap! <M-S-n> <Home>
		noremap! <M-m> <End>
		noremap! <M-S-m> <End>

	" Edits
		" Deletes
		noremap! <Del> <BS>
		noremap! <M-Del> <BS>
		noremap! <BS> <BS>
		noremap! <M-BS> <BS>
		noremap! <M-e> <BS>

" Sele
	" Modes
	noremap <Esc> <Esc>
	vnoremap <Space> <Del><Insert>

	" Expand
	vnoremap s V
	vnoremap S V

	" Movement
	vnoremap U o
	vnoremap O O

	" Edits
		" Moves
		noremap bj <
		noremap bl >

		" Deletes
		vnoremap <Del> <Del>
		vnoremap <BS> <Del>
		vnoremap e <Del>
		vnoremap E <Del>

		" Clipboards
		vnoremap C y
		vnoremap D d
		vnoremap X d
		vnoremap v <Del>"+gP
		vnoremap V gP

" GUT
	" Movements
	noremap <Up> <Up>
	noremap <C-Up> {
	noremap <Down> <Down>
	noremap <C-Down> }
	noremap <Left> <Left>
	noremap <C-Left> b
	noremap <Right> <Right>
	noremap <C-Right> e<Right>

	" Selects
	noremap <S-Up> v<Up>
	vnoremap <S-Up> <Up>
	noremap <S-C-Up> v{
	vnoremap <S-C-Up> {
	noremap <S-Down> v<Down>
	vnoremap <S-Down> <Down>
	noremap <S-C-Down> v}
	vnoremap <S-C-Down> }
	noremap <S-Left> v<Left>
	vnoremap <S-Left> <Left>
	noremap <S-C-Left> vb
	vnoremap <S-C-Left> b
	noremap <S-Right> v<Right>
	vnoremap <S-Right> <Right>
	noremap <S-C-Right> ve
	vnoremap <S-C-Right> e<Right>
