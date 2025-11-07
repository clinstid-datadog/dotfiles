-- Neovim configuration in Lua (migrated from .vimrc)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin management with lazy.nvim
require("lazy").setup({
    -- Git support
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-abolish",

    -- automatically create directory when editing a file
    "pbrisbin/vim-mkdir",

    -- comment helper
    {
    "scrooloose/nerdcommenter",
    config = function()
        vim.g.NERDSpaceDelims = 1
    end
    },
    "ryanoasis/vim-devicons",

    -- file browser
    "jlanzarotta/bufexplorer",

    -- NERDTree
    {
    "preservim/nerdtree",
    config = function()
        vim.g.NERDTreeShowHidden = 1
    end
    },

    -- color schemes
    "clinstid/vim-github-dark",
    "cormacrelf/vim-colors-github",

    -- markdown support
    "godlygeek/tabular",
    {
    "preservim/vim-markdown",
    dependencies = { "godlygeek/tabular" },
    config = function()
        vim.g.vim_markdown_folding_disabled = 1
        vim.g.vim_markdown_new_list_item_indent = 0
        vim.g.vim_markdown_conceal = 2
        vim.g.vim_markdown_recommended_style = 0
    end
    },
    "mzlogin/vim-markdown-toc",

    -- Python
    "hynek/vim-python-pep8-indent",

    -- Tags and navigation
    "preservim/tagbar",

    -- Language support
    "pearofducks/ansible-vim", -- ansible dialect of yaml
    "skilstak/vim-abnf-utf8", -- ABNF syntax
    "stephpy/vim-yaml",
    "groenewege/vim-less",
    "hail2u/vim-css3-syntax",
    "pangloss/vim-javascript",
    {
    "othree/javascript-libraries-syntax.vim",
    config = function()
        vim.g.used_javascript_libs = 'angularjs,jquery'
    end
    },
    "myhere/vim-nodejs-complete",
    "moll/vim-node",
    {
    "elzr/vim-json",
    config = function()
        vim.g.vim_json_syntax_conceal = 0
    end
    },
    { "cespare/vim-toml", branch = "main" },
    "lifepillar/pgsql.vim",
    "aklt/plantuml-syntax",
    "craigmac/vim-mermaid",
    "clinstid/mako.vim",
    "vim-scripts/haproxy",
    "clinstid/nginx.vim",
    "mogelbrod/vim-jsonpath",
    "hashivim/vim-terraform",
    { "jvirtanen/vim-hcl", branch = "main" },
    "PProvost/vim-ps1", -- powershell

    -- Go
    -- {
        -- "fatih/vim-go",
        -- config = function()
            -- vim.g.go_def_mode = 'gopls'
            -- vim.g.go_info_mode = 'gopls'
            -- vim.g.go_gopls_settings = {
                -- directoryFilters = {
                    -- "-bazel-bin",
                    -- "-bazel-out",
                    -- "-bazel-testlogs",
                    -- "-bazel-mypkg",
                    -- "-bazel-dd-source",
                    -- "-domains/eee",
                    -- "-domains/aaa",
                    -- "-domains/atlas",
                    -- "-domains/seceng",
                    -- "-domains/redapl",
                    -- "-domains/compliance",
                    -- "-domains/event_platform",
                    -- "-domains/metrics",
                -- }
            -- }
        -- end
    -- },

    "towolf/vim-helm",

    { 'neoclide/coc.nvim', branch = 'release', },

    -- Git integration
    "airblade/vim-gitgutter",

    -- TypeScript
    "leafgarland/typescript-vim",
    "Quramy/tsuquyomi",
    "peitalin/vim-jsx-typescript",

    -- FZF
    {
    "junegunn/fzf",
    build = function()
        vim.fn["fzf#install"]()
    end
    },
    {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    },

    -- Utilities
    {
    "nathanaelkane/vim-indent-guides",
    config = function()
        vim.g.indent_guides_enable_on_vim_startup = 1
        -- vim.g.indent_guides_guide_size = 1
        vim.g.indent_guides_auto_colors = 1
    end
    },
    "pedrohdz/vim-yaml-folds",
    "shime/vim-livedown", -- Live markdown preview
    {
    "junegunn/goyo.vim",
    config = function()
        vim.g.goyo_width = '120'
        vim.g.goyo_height = '950%'
    end
    },
    {
    "dkarter/bullets.vim",
    config = function()
        vim.g.bullets_enabled_file_types = {'markdown', 'text'}
        vim.g.bullets_checkbox_markers = ' x'
        vim.g.bullets_nested_checkboxes = 0
    end
    },
    "dbakker/vim-projectroot",
    "rust-lang/rust.vim",
    {
    "vimwiki/vimwiki",
    config = function()
        vim.g.vimwiki_list = {{path = '~/vimwiki/', syntax = 'markdown', ext = 'md'}}
        vim.g.vimwiki_global_ext = 0
    end
    },
    "chrisbra/unicode.vim",

    -- Bazel plugins
    "google/vim-maktaba",
    {
    "bazelbuild/vim-bazel",
    dependencies = { "google/vim-maktaba" },
    },
    "cappyzawa/starlark.vim",

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate"
    },


    -- AI Coding Companion
    {
        "olimorris/codecompanion.nvim",
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    -- autoclose brackets and other pairs
    -- {
        -- 'altermo/ultimate-autopair.nvim',
        -- event={'InsertEnter','CmdlineEnter'},
        -- branch='v0.6', --recommended as each new version will have breaking changes
        -- opts={
        -- },
    -- },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
})

-- Basic settings
--vim.opt.nocompatible = false
vim.cmd('filetype on')

-- Status line configuration
vim.opt.laststatus = 2
-- vim.opt.statusline = '%t %{fugitive#statusline()}%=(%{strlen(&ft)?&ft:\'-\'}|%{strlen(&fenc)?&fenc:\'-\'}|%{strlen(&ff)?&ff:\'-\'}) %-9.(L%l C%c%) %<%P'

-- General settings
vim.opt.ruler = true
vim.opt.hidden = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.backspace = {'indent', 'eol', 'start'}
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.copyindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.undolevels = 1000
vim.opt.title = true
vim.opt.errorbells = false
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.encoding = 'utf-8'
vim.opt.autochdir = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.display:append('lastline')
vim.opt.history = 1001
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.conceallevel = 0
vim.opt.foldlevel = 99
vim.opt.updatetime = 300
vim.opt.regexpengine = 0
-- vim.opt.fileformat = 'unix'

-- Visual settings
vim.opt.synmaxcol = 300
vim.opt.termguicolors = true
vim.opt.fillchars = 'vert:│'
vim.opt.guifont = 'Hack Nerd Font:h12'

-- File handling
vim.opt.wildmenu = true
vim.opt.wildmode = {'longest', 'list', 'full'}
vim.opt.wildignore:append({'bazel-*/*', '/.git/*'})

-- Backup and swap files
vim.opt.directory = vim.fn.expand('$HOME/.vim/swapfiles//')
vim.opt.backupdir = vim.fn.expand('$HOME/.vim/backup//')

-- List characters
vim.opt.listchars = {tab = '»·', trail = '·', conceal = '·'}

-- Completion settings
vim.opt.completeopt = {'noinsert', 'menuone', 'noselect', 'preview'}
vim.opt.shortmess:append('c')

-- Format options
vim.opt.formatoptions = 'tcroqln'

-- Mouse settings for different terminal types
if vim.fn.has('mouse_sgr') == 1 then
    vim.opt.ttymouse = 'sgr'
elseif vim.fn.has('nvim') == 0 then
    vim.opt.ttymouse = 'xterm2'
end

-- Enable syntax highlighting
vim.cmd('syntax enable')

-- Plugin-specific configurations
vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<c-b>'
vim.g.UltiSnipsJumpBackwardTrigger = '<c-z>'
vim.g.UltiSnipsEditSplit = 'vertical'

vim.g.pymode_folding = 0
vim.g.pymode_options_max_line_length = 120
vim.g.pymode_lint_ignore = 'C901'
vim.g.pymode_virtualenv = 1
vim.g.pymode_options = 0

vim.g.syntastic_python_flake8_args = '--max-line-length=120'

vim.g.python_highlight_all = 1

vim.g.session_autoload = 'no'
vim.g.session_autosave = 'yes'

vim.g.instant_markdown_autostart = 0
vim.g.instant_markdown_slow = 1

vim.g.ale_completion_enabled = 1
vim.g.ale_set_loclist = 0
vim.g.ale_keep_list_window_open = 1

vim.g.delimitMate_nesting_quotes = {'"', "'", '`'}
vim.g.delimitMate_expand_space = 1
vim.g.delimitMate_expand_cr = 1

vim.g.black_linelength = 120

vim.g.ctrlp_max_files = 1000000
vim.g.ctrlp_clear_cache_on_exit = 0

vim.g.ag_working_path_mode = 'r'

vim.g.VimTodoListsDatesEnabled = 1

vim.g.wiki_root = '~/Notes'

vim.g.python_host_prog = '$HOME/.pyenv/shims/python2'
vim.g.python3_host_prog = '$HOME/.pyenv/shims/python3'

-- Color scheme configuration
vim.g.PaperColor_Theme_Options = {
    theme = {
    default = {
        transparent_background = 1
    }
    }
}

-- Functions
local function open_weekly_notes()
    local notes_file = vim.fn.system('~/bin/weekly_notes.py')
    vim.cmd('edit ' .. notes_file)
end

local function light_theme()
    vim.opt.background = 'light'
    vim.cmd('colorscheme github')
    vim.cmd('highlight normal guibg=NONE')
end

local function dark_theme()
    vim.opt.background = 'dark'
    vim.cmd('colorscheme ghdark')
end

vim.cmd([[
function! FindGitRoot()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
]])

-- Set default color scheme
dark_theme()

-- Key mappings
vim.g.mapleader = '\\'

-- Copy and paste mappings
vim.keymap.set('n', '<C-A-v>', '"*p')
vim.keymap.set('v', '<C-c>', '"*y')
vim.keymap.set('i', '<C-S-v>', '<C-r>+')
vim.keymap.set('v', '<C-S-c>', '"+y')

-- File and buffer navigation
vim.keymap.set('n', '<leader>e', ':NERDTreeToggle<cr>')
vim.keymap.set('n', '<C-p>', ':ProjectFiles<cr>')
vim.keymap.set('n', '<leader>bf', ':Buffers<cr>')
vim.keymap.set('n', '<leader>h', ':History<cr>')
vim.keymap.set('n', '<leader>mr', ':History<cr>')
vim.keymap.set('n', '<leader>ft', ':Filetypes<cr>')

-- Search and replace
vim.keymap.set('n', '<leader>w', ':%s/\\s\\+$//e<cr>')
vim.keymap.set('n', '<leader>q', ':set nohlsearch<cr>')
vim.keymap.set('n', '<BS>', ':noh<CR><BS>')
vim.keymap.set('n', '<leader>k', function()
    vim.cmd('exe "Grg!" expand("<cword>")')
end)
vim.keymap.set('n', '<leader>rg', ':<C-u>ProjectRootExe Rg<cr>')
vim.keymap.set('n', '<leader>ag', ':Rag <C-R><C-W><CR>', {silent = true})

-- Utility mappings
vim.keymap.set('n', '<leader>sp', ':set paste<cr>')
vim.keymap.set('n', '<leader>np', ':set nopaste<cr>')
vim.keymap.set('n', '<leader>so', ':set spell<cr>')
vim.keymap.set('n', '<leader>sf', ':set nospell<cr>')
vim.keymap.set('n', '<leader>i', ':IndentGuidesToggle<cr>')
vim.keymap.set('n', '<leader>p', function()
    print(vim.fn.expand('%:p'))
end)
vim.keymap.set('n', '<leader>tb', ':TagbarToggle<cr>')
vim.keymap.set('n', '<leader>te', ':terminal<cr>')
vim.keymap.set('n', '<leader>go', ':Goyo<cr>')
vim.keymap.set('n', '<leader>mp', ':LivedownPreview<cr>')

-- Theme switching
vim.keymap.set('n', '<leader>ls', light_theme)
vim.keymap.set('n', '<leader>ds', dark_theme)

-- Notes and productivity
vim.keymap.set('n', '<leader>wn', open_weekly_notes, {silent = true})
vim.keymap.set('n', '<leader>fn', function()
    vim.fn['fzf#run']({sink = 'e', dir = '~/Notes'})
end)
vim.keymap.set('n', '<leader>sn', ':!~/bin/sync_notes<cr><cr>')
vim.keymap.set('n', '<leader>nv', ':NV<cr>', {silent = true})
vim.keymap.set('n', '<leader>wl', ':e ~/Notes/worklog.md<cr>G')
vim.keymap.set('n', '<leader>td', ':silent grep "\\[ \\]" %<cr>')

-- Date insertion
vim.keymap.set('n', '<leader>id', 'O<esc>"=strftime("%b %d %Y\\n")<CR>P<CR>i')
vim.keymap.set('n', '<leader>td', '"=strftime("# %F")<cr>P')

-- Markdown
vim.keymap.set('n', '<leader>tf', ':TableFormat<cr>')
vim.keymap.set('n', '<leader>toc', ':GenTocGFM<cr>')

-- Session management
vim.keymap.set('n', '<leader>os', ':OpenSession<cr>')

-- Visual mode mappings
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Override Y mapping
vim.keymap.set('n', 'Y', 'yy')

-- Debug mapping
vim.keymap.set('n', '<F10>', function()
    local line = vim.fn.line('.')
    local col = vim.fn.col('.')
    local hi = vim.fn.synIDattr(vim.fn.synID(line, col, 1), 'name')
    local trans = vim.fn.synIDattr(vim.fn.synID(line, col, 0), 'name')
    local lo = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(line, col, 1)), 'name')
    print(string.format('hi<%s> trans<%s> lo<%s>', hi, trans, lo))
end)

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- File type associations
autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.sky',
    command = 'set filetype=starlark'
})

autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.star',
    command = 'set filetype=starlark'
})

autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.mako',
    command = 'set filetype=mako'
})

autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.ng-template',
    command = 'set filetype=html'
})

autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.template',
    command = 'set filetype=json'
})

autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*/playbooks/*.yml',
    command = 'set filetype=ansible'
})

autocmd({'BufNewFile', 'BufRead'}, {
    pattern = 'Dockerfile*',
    command = 'set filetype=dockerfile'
})

autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*Berksfile*',
    command = 'set filetype=ruby'
})

autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.g',
    command = 'set filetype=antlr3'
})

autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.g4',
    command = 'set filetype=antlr4'
})

autocmd({'BufRead', 'BufNewFile'}, {
    pattern = 'Jenkinsfile',
    command = 'set filetype=groovy'
})

autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.jira',
    command = 'set filetype=confluencewiki'
})

autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.confluence',
    command = 'set filetype=confluencewiki'
})

autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.tsx',
    command = 'set filetype=typescript'
})

autocmd({'BufNewFile', 'BufRead'}, {
    pattern = 'devcontainer.json',
    command = 'setlocal filetype=jsonc'
})

-- Other autocommands
autocmd('FileType', {
    pattern = 'markdown',
    command = 'setlocal spell'
})

autocmd('BufEnter', {
    pattern = '*',
    command = 'silent! lcd %:p:h'
})

autocmd('BufWritePre', {
    pattern = '*',
    command = ':%s/\\s\\+$//e'
})

autocmd('FileType', {
    pattern = 'gitcommit',
    callback = function()
    vim.fn.setpos('.', {0, 1, 1, 0})
    end
})

autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
    local line = vim.fn.line([["'"]])
    if line > 1 and line <= vim.fn.line('$') then
        vim.cmd([[exe "normal! g'\""]])
    end
    end
})

autocmd('BufWritePost', {
    pattern = '*.py',
    command = 'silent execute "!black %"'
})

-- Quickfix autocommands
local quickfix_group = augroup('quickfix', {clear = true})
autocmd('QuickFixCmdPost', {
    group = quickfix_group,
    pattern = '[^l]*',
    command = 'cwindow'
})

autocmd('QuickFixCmdPost', {
    group = quickfix_group,
    pattern = 'l*',
    command = 'lwindow'
})

-- Commands
vim.cmd([[
command! -nargs=* Rag call fzf#vim#ag(<q-args>, FindGitRoot(), g:fzf#vim#with_preview())
command! ProjectFiles execute 'GFiles -c -o' FindGitRoot()
]])

-- Set tags file
vim.opt.tags = 'tags;'

-- Abbreviations
vim.cmd([[
iab nday <C-R>=strftime("## %F %a\n")<cr>
iab <expr> nlog strftime("_%H:%M:%S_")
iab newtd [ ]
]])

-- Highlight overrides
vim.cmd('highlight link CocUnusedHighlight Error')

-- Lualine config
require('lualine').setup()

-- inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
-- select completions with enter
vim.keymap.set('i', '<CR>', function()
    if vim.fn['coc#pum#visible']() == 1 then
        return vim.fn['coc#pum#confirm']()
    else
        return '\r'
    end
end, { silent = true, expr = true })

function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.')[col - 1]:match('%s') ~= nil
end

-- Use Tab to trigger completion or move to the next item
vim.keymap.set('i', '<Tab>', function()
  if vim.fn['coc#pum#visible']() == 1 then
    return vim.fn['coc#pum#next'](1)
  elseif _G.check_back_space() then
    return '<Tab>'
  else
    return vim.fn['coc#refresh']()
  end
end, { expr = true, silent = true })

-- Use Shift-Tab to select the previous item
vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn['coc#pum#visible']() == 1 and vim.fn['coc#pum#prev'](1) or '<S-Tab>'
end, { expr = true, silent = true })

