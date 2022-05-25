" -----------------------------------------------------
" Plugins
" -----------------------------------------------------

call plug#begin()
" autocompletion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-angular', {'do': 'yarn install --frozen-lockfile && yarn build'}
" bufferline and statusline
Plug 'akinsho/bufferline.nvim', {'tag': 'v2.*'}
Plug 'itchyny/lightline.vim'
" editing
Plug 'folke/which-key.nvim'
Plug 'justinmk/vim-sneak'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" eye candy
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'psliwka/vim-smoothie'
" file exploring
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
call plug#end()

" -----------------------------------------------------
" Settings
" -----------------------------------------------------

" indentation
filetype plugin indent on
set expandtab
set shiftround
set shiftwidth=2
set smartindent
set tabstop=2
" user interface
colorscheme dracula
highlight clear LineNr
highlight clear SignColumn
set mouse=a
set noshowmode
set nowrap 
set number
set relativenumber
set scrolloff=10
set showtabline=2
set sidescrolloff=3
set signcolumn=number
set splitright
set termguicolors
" miscellaneous
au BufWinEnter * set formatoptions-=cro
set clipboard=unnamedplus
set ignorecase
set nobackup
set nowritebackup
set shortmess+=c
set smartcase
set timeoutlen=100
set updatetime=300

" -----------------------------------------------------
" Mappings
" -----------------------------------------------------

let mapleader = "\<Space>"
" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" highlight yanks
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END
" navigate buffers
nnoremap <Tab> :BufferLineCycleNext<CR>
nnoremap <S-Tab> :BufferLineCyclePrev<CR>
" visual mode tabbing
vnoremap < <gv
vnoremap > >gv
" window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" -----------------------------------------------------
" Plugins settings
" -----------------------------------------------------

" bufferline
lua << EOF
require("bufferline").setup{
  options = {
      diagnostics = "coc",
      offsets = {{filetype = "nerdtree", text = " "}},
      show_buffer_close_icons = false,
      show_close_icon = false,
    }
}
EOF

" conquer of completion
let g:coc_user_config = {}
let g:coc_user_config["pairs.enableCharacters"] = ["(", "[", "{", "'", "\"", "`"]
let g:coc_user_config["diagnostic"] = {
      \ "errorSign": "✖",
      \ "warningSign": "⚠",
      \ "infoSign": "●",
      \ "hintSign": "○",
      \ "virtualText": v:true,
      \ "virtualTextCurrentLineOnly": v:true
      \ }
let g:coc_user_config["coc.preferences.formatOnSaveFiletypes"] = [
      \ "typescript",
      \ "javascript",
      \ "javascript.jsx",
      \ "typescript.tsx",
      \ "typescriptreact",
      \ "javascriptreact",
      \ "html"
      \ ]
let g:coc_user_config["suggest.completionItemKindLabels"] = {
      \ "keyword": "\uf1de",
      \ "variable": "\ue79b",
      \ "value": "\uf89f",
      \ "operator": "\u03a8",
      \ "function": "\u0192",
      \ "reference": "\ufa46",
      \ "constant": "\uf8fe",
      \ "method": "\uf09a",
      \ "struct": "\ufb44",
      \ "class": "\uf0e8",
      \ "interface": "\uf417",
      \ "text": "\ue612",
      \ "enum": "\uf435",
      \ "enumMember": "\uf02b",
      \ "module": "\uf40d",
      \ "color": "\ue22b",
      \ "property": "\ue624",
      \ "field": "\uf9be",
      \ "unit": "\uf475",
      \ "event": "\ufacd",
      \ "file": "\uf723",
      \ "folder": "\uf114",
      \ "snippet": "\ue60b",
      \ "typeParameter": "\uf728",
      \ "default": "\uf29c"
      \ }
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<Cr>"
function! s:check_back_space() abort
  let col = col(".") - 1
  return !col || getline(".")[col - 1]  =~# "\s"
endfunction
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gf <Plug>(coc-fix-current)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(["vim", "help"], &filetype) >= 0)
    execute "h ".expand("<cword>")
  else
    call CocAction("doHover")
  endif
endfunction

" emmet
imap <silent><expr> <Tab> emmet#expandAbbrIntelligent("\<Tab>")

" fuzzy finder
let $FZF_DEFAULT_COMMAND = "rg --files --hidden"
let g:fzf_colors = {
      \ "fg":      ["fg", "Normal"],
      \ "bg":      ["bg", "Normal"],
      \ "hl":      ["fg", "Search"],
      \ "fg+":     ["fg", "Normal"],
      \ "bg+":     ["bg", "Normal"],
      \ "hl+":     ["fg", "DraculaOrange"],
      \ "info":    ["fg", "DraculaPurple"],
      \ "border":  ["fg", "Ignore"],
      \ "prompt":  ["fg", "DraculaGreen"],
      \ "pointer": ["fg", "Exception"],
      \ "marker":  ["fg", "Keyword"],
      \ "spinner": ["fg", "Label"],
      \ "header":  ["fg", "Comment"],
      \}

" lightline
let g:lightline = {
      \ "colorscheme": "dracula",
      \ "active": {
      \   "right": [ [ "lineinfo" ], [ "filetype" ] ]
      \ },
      \ "component_function": {
      \   "filename": "LightlineFilename",
      \   "mode": "LightlineMode",
      \ },
      \ "enable": {
      \   "tabline": 0
      \ }
      \ }
function! LightlineFilename()
  return &filetype ==# "nerdtree" || &filetype ==# "vim-plug" ? '' :
        \ expand("%:t") !=# '' ? expand("%:t") : "[No Name]" 
endfunction
function! LightlineMode()
  return &filetype ==# "nerdtree" || &filetype ==# "vim-plug" ? '' :
        \ lightline#mode()
endfunction

" nerdtree
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.vscode$']

" smoothie
let g:smoothie_update_interval = 5

" sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

" treesitter
lua << EOF
require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "css",
    "go",
    "html",
    "java",
    "javascript",
    "json",
    "python",
    "tsx",
    "typescript"
  }
}
EOF

" whichkey
command BufOnly silent! execute "%bd|e#|bd#"
command CloseBuf silent! execute "bd"
lua << EOF
local setup = {
  plugins = {
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
    },
  },
  layout = {
    align = "center",
  },
}
local mappings = {
  ["C"] = {"<cmd>BufOnly<Cr>", "Close other buffers"},
  ["F"] = {"<cmd>Rg<Cr>", "Find text"},
  ["c"] = {"<cmd>CloseBuf<Cr>", "Close buffer"},
  ["e"] = {"<cmd>NERDTreeToggle<Cr>", "Explorer"},
  ["f"] = {"<cmd>Files<Cr>", "Find file"},
  ["h"] = {"<cmd>nohlsearch<Cr>", "No highlight"},
  ["q"] = {"<cmd>q!<Cr>", "Quit"},
  ["r"] = {"<Plug>(coc-rename)", "Rename variable"},
  ["w"] = {"<cmd>w!<Cr>", "Save"},
}
require("which-key").setup(setup)
require("which-key").register(mappings, {prefix = "<leader>"})
EOF
