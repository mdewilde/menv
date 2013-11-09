" (C) 2013 David 'Mokon' Bond, All Rights Reserved

" =============================================================================
" Load plugins

" pathogen plugins that we need to disable on this host.
let g:pathogen_disabled = []

if v:version < '703' || !has('python')
      call add(g:pathogen_disabled, 'numbers.vim')
      " clang_complete
endif

execute pathogen#infect()

" =============================================================================
" Basic settings.

filetype plugin indent on " Enable lang dep. indenting
syntax on " We want syntax coloring

set mouse=v " Use the mouse in visual mode.
set hlsearch " Highlight search.
set ai " Auto indentation.
set nocp " I don't care about compat with vi.
set pastetoggle=<F2> " Quick shortcut to toggle paste mode.
set autoread " Watch for file changes.
set showmatch " Show the matching bracket.
set cmdheight=2 " Cmdline two high.
set ruler " Show the current pos. at the bottom.
set tabstop=2 shiftwidth=2 expandtab " My default indentation.
set number " Number lines.
set laststatus=2 " Always show the last status msg.
set clipboard=unnamed
set hid
set wildmenu

autocmd FileType make setlocal noexpandtab " Makefiles need tabs. Don't convert
                                           " those to spaces.

" =============================================================================
" Some more complex settings.

" If supported color the 80th colomn.
if exists('+colorcolumn')
  set colorcolumn=80
endif

" Color anything over 80 chars red.
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

if filereadable("$menv_dotfiles_dir/style/${CODING_STYLE}.vim)
  source $menv_dotfiles_dir/style/${CODING_STYLE}.vim
endif

" A nice function that strips trailing white space from a file. Mapped to
" leader space.
function! <SID>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<CR>

function! FindAndReplaceAllConfirm(from, to)
  exe '%s/' . a:from . '/' . a:to . '/gc'
endfunction

function! FindAndReplaceAll(from, to)
  exe '%s/' . a:from . '/' . a:to . '/g'
endfunction

highlight User1 guifg=Red   guibg=NONE ctermfg=Red   ctermbg=NONE
highlight User2 guifg=Blue  guibg=NONE ctermfg=Blue  ctermbg=NONE
highlight User3 guifg=Green guibg=NONE ctermfg=Green ctermbg=NONE
highlight User4 guifg=White guibg=NONE ctermfg=White ctermbg=NONE
highlight User5 guifg=Gray  guibg=NONE ctermfg=Gray  ctermbg=NONE

" Update the status line to something better.
set statusline =
set statusline +=%1*%h\ %w\
set statusline +=%2*%{&ff}                       " file format
set statusline +=%1*%y                           " file type
set statusline +=\ %2*%r%{getcwd()}              " cwd
set statusline +=%1*\ %<%F%*                     " full path
set statusline +=%1*%m                           " modified flag
set statusline +=%2*%m                           " readonly flag
set statusline +=\ %3*%l/%L                      " line
set statusline +=\ %v                            " column number
set statusline +=\ %2*0x%04B\                    " char under cursor

" Spell check.
map <leader>ss :setlocal spell!<cr>

" Toggle nerd tree.
"
map <leader>n :NERDTreeToggle<CR>

nnoremap <F3> :NumbersToggle<CR>

" =============================================================================
" Some useful vimrc settings I don't want enabled by default.

" set ignorecase " Case insensitive search
" set smartcase

" I need to figure out how to use this with my overlength highlight.
" highlight WhitespaceEOL ctermbg=red guibg=red
" match WhitespaceEOL /\s\+$/
"
" Spell Checking!
" set spell spelllang=en_us
" setlocal spell spelllang=en_us
"
" These commands would open a nerd tree and switch the focus to the file being
" opened but in general  I find they annoy me more than are useful. If I need
" to use the nerdtree I can just open it by hand.
" autocmd VimEnter * NERDTree
" autocmd BufEnter * NERDTreeMirror
" autocmd VimEnter * wincmd w

