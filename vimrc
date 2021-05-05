"All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.


" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" filetypes and 'compatible' don't work together well, since being Vi
" compatible means options are global.  Resetting 'compatible' is recommended,
" if you didn't do that already.
set nocompatible
filetype off

" plugins...............................................

" set the runtime path(s) to include Vundle and initialize:
set rtp+=~/.vim/bundle/Vundle.vim
if filereadable("C:/Users/Moritz.Koenemann/AppData/Local/Vim/vim81/bundle/Vundle.vim")
  set rtp+=C:/Users/Moritz.Koenemann/AppData/Local/Vim/vim81/bundle/Vundle.vim
endif
call vundle#begin()

" let Vundle manage Vundle:
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline' 
Plugin 'kien/ctrlp.vim'
Plugin '907th/vim-auto-save'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'jnurmine/Zenburn'
" Plugin 'OmniSharp/omnisharp-vim'
Plugin 'w0rp/ale'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
filetype plugin indent on


" plugin config.........................................

if has('win32')
    let g:ycm_server_python_interpreter = "python37.bat"
else
    let g:ycm_server_python_interpreter = "python3.8"
endif

let g:ctrlp_working_path_mode = 0

if filereadable('C:\Users\Moritz.Koenemann\AppData\Local\ctags\ctags.exe')
  let g:tagbar_ctags_bin = 'C:\Users\Moritz.Koenemann\AppData\Local\ctags\ctags.exe'
endif 

" deactivate 907th/vim-auto-save by default..
let g:auto_save = 0

" Use the stdio OmniSharp-roslyn server
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_selector_ui = 'ctrlp'

" Set the type lookup function to use the preview window instead of echoing it
"let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview

" Fetch full documentation during omnicomplete requests.
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

" Update semantic highlighting after all text changes
let g:OmniSharp_highlight_types = 3
" Update semantic highlighting on BufEnter and InsertLeave
"let g:OmniSharp_highlight_types = 2


" colorscheme...........................................

" for more colorschemes visit <https://github.com/rafi/awesome-vim-colorschemes>

if has('gui_running')
  "set background=dark
  colorscheme github
  "colorscheme deep-space
  set guifont=Consolas:h9
else
  colorscheme zenburn
endif


" global configuration..................................

set encoding=utf-8

syntax on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" show (partial) command in status line.
set showmatch		" show matching brackets.
set showmode		" Zeige aktuellen Modus
set ignorecase
set smartcase		" do smart case matching
set incsearch		" incremental search
set hlsearch		" enable highlighting at searching
set hidden             	" hide buffers when they are abandoned
set mouse=a		" enable mouse usage (all modes)
set ruler		" show current cursor position
set number		" show line numbers
set history=500		" Anzahl gespeicherter Befehle
set wildmenu		" TAB-Vervollstaendigung in Kommandozeile
set belloff=all     	" bringe VIM zum Schweigen
set hlsearch          	" highlight search pattern:

" Speichern von Cursorpositionen, Faltungen, lokale
" Optionen/Mappings/Abkürzungen (kann zu Problemen in einzelnen Dateien
" fuehren, dann die config Datei unter ~/.vim/view loeschen):
" au BufWinLeave * mkview
" au BufWinEnter * silent! loadview

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
 
" function definitions..................................

fu! Make()
    exec 'wall'
    if has('win32')
        exec '!nmake /nologo'
    else
        exec '!make'
    endif
endfun

" set the comment marker to the beginning of the current line
" (this assumes the variable b:Comment to be set)
fu! Comment()
    exec 's@^@'.b:Comment.' @'
endfun

" remove the comment marker from the beginning of the current line
" (this assumes the variable b:Comment to be set)
fu! Uncomment()
    exec 's@^'.b:Comment.' \?@@'
endfun

" map Umlaute:
:dig ae 228
:dig oe 246
:dig ue 252
:dig ss 223
:dig AE 196
:dig OE 214
:dig UE 220

:dig OK 10003

" global keyboard mappings..............................

" leader key:
let mapleader = ","

" get backspace to work:
set backspace=indent,eol,start

" faster tab switching:
nnoremap > gt
nnoremap < gT

" faster window switching:
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k

" Make window splitting more intuitive:
set splitbelow
set splitright
set diffopt=vertical

" toggle fold with spacebar:
nnoremap <space> za

" refactoring: replace variable with a single stroke!
" first try w/o substitution:
"map <leader>v xm`O<esc>p0inew_var = <esc>``inew_var<esc>m>gv  
" better: prepare a substitue command:
map <leader>v yO<esc>pa = <esc>pm':'',$s/\V<C-r>"//gc<left><left><left>

" printf variable under cursor for debugging
nmap <leader>d byeoprintf("<esc>pa: %x\n", <esc>pa);<esc>Fxs

" YouCompleteMe: jump to declaration:
"map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" open Tagbar and jump right to it:
nmap <leader>b :TagbarOpen<CR><C-w>l

nmap <leader>c :call Comment()<CR>j
vmap <leader>c :call Comment()<CR>j
nmap <leader>u :call Uncomment()<CR>j
vmap <leader>u :call Uncomment()<CR>j

" magic refactor functions.............
"  extract variable:
nmap <leader>v yO<esc>pa = <esc>pm':'',$s/\V<C-r>"//gc<left><left><left>

" autocommands..........................................

" (debugging only)
"set verbose=9

augroup pythonsource
    " clear this augroup (in case of reloading _vimrc):
    autocmd!
    au BufNewFile,BufRead *.py let b:Comment = '#'
    au BufNewFile,BufRead *.py set expandtab  " convert tab to spaces...
    au BufNewFile,BufRead *.py set tabstop=4  " ...4 spaces to be precise
    au BufNewFile,BufRead *.py set shiftwidth=4  " ...also on linebreaks
    au BufNewFile,BufRead *.py set softtabstop=4
    au BufNewFile,BufRead *.py set textwidth=90
    " au BufNewFile,BufRead *.py set foldmethod=indent  " =expr (using SimpylFold)
    " au BufNewFile,BufRead *.py set autoindent
    " au BufNewFile,BufRead *.py set fileformat=dos
    " execute visual selection as python script:
    au BufNewFile,BufRead *.py vnoremap <F9> :w !python<CR>
    " ...and on current line in normal mode:
    au BufNewFile,BufRead *.py nnoremap <F9> 0mp:'pw !python<CR>
    " execute the script on pressing Enter:
    au BufNewFile,BufRead *.py nnoremap <C-M> :w !python<CR>
    " perform doctest on current file:
    au BufNewFile,BufRead *.py nnoremap <F8> :!python -m doctest %<CR>
    " send selection to terminal window (use '%autoindent off' when in ipython)
    au BufNewFile,BufRead *.py vnoremap <leader>e y<C-w>j<C-w>"0<CR><C-w>k
    " Plugin related stuff..
    au BufNewFile,BufRead *.py let b:auto_save=1
    au BufNewFile,BufRead *.py syntax keyword pythonSelf self
    au BufNewFile,BufRead *.py highlight def link pythonSelf Special
augroup end

augroup htmlsource
    " clear this augroup (in case of reloading _vimrc):
    autocmd!
    au BufNewFile,BufRead *.html set expandtab  " convert tab to spaces...
    au BufNewFile,BufRead *.html set tabstop=2  " ...2 spaces to be precise
    au BufNewFile,BufRead *.html set shiftwidth=2  " ...also on linebreaks
    au BufNewFile,BufRead *.html set softtabstop=2
    au BufNewFile,BufRead *.html set syntax=html
augroup end

augroup csource
    autocmd!
    au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs let b:Comment = '//'
    au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs nnoremap <CR> :call Make()<CR>
    " au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs set fileformat=dos
    au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs set softtabstop=4
    au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs set textwidth=90
    au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs set expandtab
    au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs set tabstop=4
    au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs set shiftwidth=4
    au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs set autoindent
    au BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp,*.cs set foldmethod=indent
augroup end

augroup csharpsource
    autocmd!

    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    autocmd CursorHold *.cs OmniSharpTypeLookup

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> <Leader>g :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    "autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    "autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup end

augroup matlabsource
    autocmd!
    au BufNewFile,BufRead *.m set syntax=matlab
    au BufNewFile,BufRead *.m set foldmarker=>>>,<<<
    au BufNewFile,BufRead *.m set foldmethod=marker
augroup end

augroup latexsource
    autocmd!
    au BufNewFile,BufRead *.tex,*.cls nnoremap <CR> :call Make()<CR>
    au BufNewFile,BufRead *.tex,*.cls let b:Comment = "%"
    " finde mit STRG-p auch sachen wie 'fig:blub'..
    au BufNewFile,BufRead *.tex,*.cls set iskeyword+=:
    au BufNewFile,BufRead *.tex,*.cls set noexpandtab
augroup end

augroup plaintext
    autocmd!
    au BufNewFile,BufRead *.txt set noexpandtab
    au BufNewFile,BufRead *.txt if 'modifiable' | set fileformat=dos | endif
augroup end

augroup markdown
    autocmd!
    au BufNewFile,BufRead *.md if 'modifiable' | set fileformat=dos | endif
    au BufNewFile,BufRead *.md set fileencoding=utf-8
    au BufNewFile,BufRead *.md set textwidth=85
augroup end
