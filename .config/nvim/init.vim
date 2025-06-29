set clipboard=unnamedplus

if exists('g:vscode')
else
    " Set leader key
    let g:mapleader = ','

    " Remap mode switch
    :inoremap jk <esc>
    :inoremap ол <esc>
    :inoremap <esc> <nop>

    " Set up the plugin manager (Vim-Plug)
    call plug#begin('~/.vim/plugged')
        Plug 'nvim-lua/plenary.nvim'
        Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
        Plug 'itchyny/lightline.vim'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'stevearc/oil.nvim'
        Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
        Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
        Plug 'github/copilot.vim'
        Plug 'xiyaowong/transparent.nvim'
        Plug 'rmagatti/auto-session'
    call plug#end()

    " Setup plugins
    lua << EOF
require("oil").setup({ view_options = { show_hidden = true }})
require("nvim-treesitter.configs").setup({
    auto_install = true,
    highlight = { enable = true },
    ignore_install = { "help" },
    ensure_installed = { 
        "c",
        "cpp",
        "lua",
        "vim",
        "help",
        "python",
        "typescript",
        "javascript",
        "tsx",
        "html",
    },
})

require("telescope").setup()
require("telescope").load_extension("fzf")

require("auto-session").setup {
    suppressed_dirs = { "~/", "~/Projects", "~/HomeProjects" },
    session_lens = {
        load_on_setup = true,
        mappings = {
            delete_session = { "i", "<C-D>" },
            alternate_session = { "i", "<C-S>" },
            copy_session = { "i", "<C-Y>" },
        },
        picker_opts = {
            -- Telescope theme options (uncomment if you want to customize)
            -- border = true,
            -- layout_config = {
            --   width = 0.8,
            --   height = 0.5,
            -- },
        },
    },
}
EOF

    " Enable syntax highlighting and indenting
    syntax on
    filetype plugin indent on

    " Setup colorscheme
    set termguicolors
    colorscheme catppuccin-latte
    let g:lightline = {'colorscheme': 'catppuccin'}

    " Save the file automatically when switching buffers or leaving insert mode
    autocmd BufLeave,InsertLeave * silent! wall

    " Indentation
    set tabstop=4
    set shiftwidth=4
    set expandtab

    " Visible
    set relativenumber
    set laststatus=2

    " Enable searching with case sensitivity
    set ignorecase
    set smartcase

    " CoC configs
    let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-sh',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-yaml',
      \ 'coc-pyright',
      \ 'coc-eslint',
      \ 'coc-clangd',
      \ 'coc-prettier',
      \ 'coc-rust-analyzer',
      \ 'coc-go',
      \ ]

    set updatetime=300
    set signcolumn=yes

    " CoC bindings
    inoremap <silent><expr> <c-space> coc#refresh()

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <leader>a <Plug>(coc-codeaction)

    inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
    inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
    inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

    nnoremap <Leader>rl :CocCommand python.runLinting<CR>
    nnoremap <Leader>rs :CocCommand pyright.restartserver<CR>
    nnoremap <Leader>oi :CocCommand editor.action.organizeImport<CR> 
    nnoremap <Leader>cf :call CocAction('format')<CR>
    nnoremap <Leader>er :CocCommand eslint.restart<CR>
    nnoremap <Leader>ef :CocCommand eslint.executeAutofix<CR>

    " Format React and TS files on save
    autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx silent! CocCommand prettier.formatFile
    autocmd BufWritePre *.rs :call CocAction('runCommand', 'editor.action.formatDocument')
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.formatDocument')

    " Setup oil - for better navigation
    nnoremap <leader>o :Oil<CR>
    nnoremap <leader>O :Oil --float<CR>

    " Hide highlight
    nnoremap <leader>hh :noh<CR>

    " Find files using Telescope command-line sugar.
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    nnoremap <leader>fr <cmd>Telescope resume<cr>

    " Auto-session keybindings
    nnoremap <leader>wr <cmd>SessionSearch<CR>
    nnoremap <leader>ws <cmd>SessionSave<CR>
    nnoremap <leader>wa <cmd>SessionToggleAutoSave<CR>

    " Map splits
    nnoremap <leader>sr :vsplit<CR>
    nnoremap <leader>sb :split<CR>
endif
