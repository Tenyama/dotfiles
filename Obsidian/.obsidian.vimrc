" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
nmap <Down> gj
nmap <Up> gk

" have $ and 0 navigate visual lines rather than logical ones
nnoremap $ g$
vnoremap $ g$
nnoremap 0 g0
vnoremap 0 g0

" Quickly remove search highlights
nmap <F9> :nohl<CR>

" Go to link under cursor
exmap go_to_link obcommand editor:follow-link
nmap gd :go_to_link<CR>

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <A-Left> :back<CR>

exmap forward obcommand app:go-forward
nmap <A-Right> :forward<CR>

exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki<CR>
nunmap s
vunmap s
map s" :surround_double_quotes<CR>
map s' :surround_single_quotes<CR>
map s` :surround_backticks<CR>
map sb :surround_brackets<CR>
map s( :surround_brackets<CR>
map s) :surround_brackets<CR>
map s[ :surround_square_brackets<CR>
map s] :surround_square_brackets<CR>
map s{ :surround_curly_brackets<CR>
map s} :surround_curly_brackets<CR>

vnoremap > >gv
vnoremap < <gv

" Focusing windows
exmap focus_left obcommand editor:focus-left
exmap focus_right obcommand editor:focus-right
exmap focus_up obcommand editor:focus-top
exmap focus_down obcommand editor:focus-bottom

nmap <C-h> :focus_left<CR>
nmap <C-l> :focus_right<CR>
nmap <C-k> :focus_up<CR>
nmap <C-j> :focus_down<CR>

" Splitting windows
exmap vs obcommand workspace:split-vertical
exmap hs obcommand workspace:split-horizontal
