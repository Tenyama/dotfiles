let mapleader="\<space>"
set relativenumber
set ic
set clipboard=unnamed
set scrolloff=10
nnoremap <leader>n :set rnu!<cr>
nnoremap <PageUp> :<Nop> 
nnoremap <PageDown> :<Nop>
nnoremap <Tab> :<C-U>tabnext<CR>
nnoremap <S-Tab> :<C-U>tabprevious<CR>
nnoremap <C-h> <C-A-l>
nnoremap <S-k> :vsc Edit.PeekDefinition<CR>
nnoremap <C-o> :vsc ProjectandSolutionContextMenus.Project.OpenFolderinFileExplorer<CR>
nnoremap gI :vsc Edit.GoToImplementation<CR>
nnoremap gr :vsc Edit.FindAllReferences<CR>
vnoremap > >gv
vnoremap < <gv
nnoremap n nzz
nnoremap N Nzz
nnoremap <A-Up> :m -2<CR>
nnoremap <A-Down> :m +1<CR>
