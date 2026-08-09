--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options
-- ============================================================
do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = true

  -- [[ Setting options ]]
  --  See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  -- Make line numbers default
  vim.o.number = true
  -- You can also add relative line numbers, to help with jumping.
  --  Experiment for yourself to see if you like it!
  -- vim.o.relativenumber = true

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  vim.o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- Show which line your cursor is on
  vim.o.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.scrolloff = 10

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  vim.o.confirm = true
end

-- ============================================================
-- SECTION 2: KEYMAPS & AUTOCMDS
-- basic keymaps, basic autocmds
-- ============================================================
do
  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- ============================================================
-- SECTION 3: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
  -- [[ Intro to `vim.pack` ]]
  -- `vim.pack` is a new plugin manager built into Neovim,
  --  which provides a Lua interface for installing and managing plugins.
  --
  --  See `:help vim.pack`, `:help vim.pack-examples` or the
  --  excellent blog post from the creator of vim.pack and mini.nvim:
  --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
  --
  --  To inspect plugin state and pending updates, run
  --    :lua vim.pack.update(nil, { offline = true })
  --
  --  To update plugins, run
  --    :lua vim.pack.update()
  --
  --
  --  Throughout the rest of the config there will be examples
  --  of how to install and configure plugins using `vim.pack`.
  --
  --  In this section we set up some autocommands to run build
  --  steps for certain plugins after they are installed or updated.

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  --
  -- To install a plugin simply call `vim.pack.add` with its git url.
  -- This will download the default branch of the plugin, which will usually be `main` or `master`
  -- You can also have more advanced specs, which we will talk about later.
  --
  -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
  --
  -- For example, lets say we want to install `guess-indent.nvim` - a plugin for
  -- automatically detecting and setting the indentation.
  --
  -- We first install it from https://github.com/NMAC427/guess-indent.nvim
  -- and then call its `setup()` function to start it with default settings.
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  -- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
  --
  -- See `:help gitsigns` to understand what each configuration key does.
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
  }

  -- Useful plugin to show you pending keybinds.
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  }

  -- [[ Colorscheme ]]
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command under that to load whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

--[[
  vim.pack.add { gh 'folke/tokyonight.nvim' }
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false }, -- Disable italics in comments
    },
  }

  -- Load the colorscheme here.
  -- Like many other themes, this one has different styles, and you could load
  -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  vim.cmd.colorscheme 'tokyonight-night'
--]]

  vim.pack.add({ 'https://github.com/ellisonleao/gruvbox.nvim' })

  require("gruvbox").setup()
  vim.cmd.colorscheme("gruvbox")

  -- Highlight todo, notes, etc in comments
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- If a nerd font is available, load the icons module for pretty icons in various plugins.
  if vim.g.have_nerd_font then
    require('mini.icons').setup()
    -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
    MiniIcons.mock_nvim_web_devicons()
  end

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end

  -- ... and there is more!
  --  Check out: https://github.com/nvim-mini/mini.nvim
end

vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim'
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox' -- gruvbox, auto
  }
}

vim.pack.add({
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  -- optional, but recommended
  "https://github.com/nvim-tree/nvim-web-devicons",
})

vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>', {})

vim.pack.add({
    'https://github.com/nvimtools/none-ls.nvim'
})

-- PAINFUL customization of my interface --

vim.pack.add({
  {
    src = 'https://github.com/goolord/alpha-nvim'
  },
  -- dependencies
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/nvim-tree/nvim-web-devicons',
})

local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

-- Set header
dashboard.section.header.val = {
    '                                                                            ',
    '                                                                            ',
    '                                                                            ',
    ' ███████╗██████╗ ██╗   ██╗███████╗██╗     ██╗     ███████╗██████╗ ██╗   ██╗ ',
    ' ██╔════╝██╔══██╗██║   ██║██╔════╝██║     ██║     ██╔════╝██╔══██╗╚██╗ ██╔╝ ',
    ' █████╗  ██║  ██║██║   ██║█████╗  ██║     ██║     █████╗  ██████╔╝ ╚████╔╝  ',
    ' ██╔══╝  ██║  ██║██║   ██║██╔══╝  ██║     ██║     ██╔══╝  ██╔══██╗  ╚██╔╝   ',
    ' ███████╗██████╔╝╚██████╔╝███████╗███████╗███████╗███████╗██║  ██║   ██║    ',
    ' ╚══════╝╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝    ',
    '                                                                            ',
    '          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗                ',
    '          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║                ',
    '          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║                ',
    '          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║                ',
    '          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║                ',
    '          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                ',
    '                                                                            ',
    '            Eduardo Ellery custom setup, because why not?                   ',
    '                                                                            ',
    '                                                                            ',
}

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
  dashboard.button('f', '󱈍  > Find file', ':cd $HOME/Workspace | Telescope find_files<CR>'),
  dashboard.button('r', '  > Recent', ':Telescope oldfiles<CR>'),
  dashboard.button('s', '  > Settings', ':e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>'),
  dashboard.button('q', '⏻  > Quit NVIM', ':qa<CR>'),
}


-- Set footer
local format_line = function(line, max_width)
  -- inserts linebreaks into line
  local formatted_line = ' '
  if line == '' then
    formatted_line = formatted_line .. ' '
    return formatted_line
  end

  -- split line by spaces into list of words
  words = {}
  target = '%S+'
  for word in line:gmatch(target) do
    table.insert(words, word)
  end

  bufstart = ''
  buffer = bufstart
  for i, word in ipairs(words) do
    if (#buffer + #word + 1) < max_width then
      buffer = buffer .. word .. ' '
      if i == #words then
        formatted_line = formatted_line .. buffer:sub(1, -2) .. ' '
        -- table.insert(formatted_lines, buffer:sub(1,-2))
      end
    else
      formatted_line = formatted_line .. buffer:sub(1, -2) .. ' '
      -- table.insert(formatted_lines, buffer:sub(1,-2))
      buffer = bufstart .. word .. ' '
    end
  end
  -- right-justify text if the line begins with -
  if line:sub(1, 1) == '-' then
    local space = string.rep(' ', max_width - #formatted_line - 2)
    formatted_line = space .. formatted_line:sub(2, -1)
  end
  return formatted_line
end

local format_fortune = function(fortune, max_width)
  -- Converts list of strings to one formatted string (with linebreaks)
  formatted_fortune = {}
  table.insert(formatted_fortune, '') -- adds spacing between alpha-menu and footer
  for _, line in ipairs(fortune) do
    local formatted_line = format_line(line, max_width)
    --formatted_fortune = formatted_fortune .. formatted_line
    table.insert(formatted_fortune, formatted_line)
  end
  return formatted_fortune
end

local get_fortune = function(fortune_list)
  -- selects an entry from fortune_list randomly
  math.randomseed(os.time())
  local ind = math.random(1, #fortune_list)
  return fortune_list[ind]
end

local fortune = function(options)
  options = options or {}
  local max_width = options.max_width or 54
  local fortune_list = options.quotes --or require("alpha.quotes")
  local fortune = get_fortune(fortune_list)
  local formatted_fortune = format_fortune(fortune, max_width)
  return formatted_fortune
end


local options = {
  -- max_width = 69,
  quotes = { -- Your own list
    {
      'Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.',
      '',
      '- Brian Kernighan',
    },
    { "If you don't finish then you're just busy, not productive." },
    { 'Adapting old programs to fit new machines usually means adapting new machines to behave like old ones.', '', '- Alan Perlis' },
    { 'Fools ignore complexity. Pragmatists suffer it. Some can avoid it. Geniuses remove it.', '', '- Alan Perlis' },
    { 'It is easier to change the specification to fit the program than vice versa.', '', '- Alan Perlis' },
    { 'Simplicity does not precede complexity, but follows it.', '', '- Alan Perlis' },
    { 'Optimization hinders evolution.', '', '- Alan Perlis' },
    { 'Recursion is the root of computation since it trades description for time.', '', '- Alan Perlis' },
    { 'It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures.', '', '- Alan Perlis' },
    { 'There is nothing quite so useless as doing with great efficiency something that should not be done at all.', '', '- Peter Drucker' },
    { "If you don't fail at least 90% of the time, you're not aiming high enough.", '', '- Alan Kay' },
    {
      'I think a lot of new programmers like to use advanced data structures and advanced language features as a way of demonstrating their ability. I call it the lion-tamer syndrome. Such demonstrations are impressive, but unless they actually translate into real wins for the project, avoid them.',
      '',
      '- Glyn Williams',
    },
    { 'I would rather die of passion than of boredom.', '', '- Vincent Van Gogh' },
    { 'If a system is to serve the creative spirit, it must be entirely comprehensible to a single individual.' },
    { "The computing scientist's main challenge is not to get confused by the complexities of his own making.", '', '- Edsger W. Dijkstra' },
    {
      "Progress in a fixed context is almost always a form of optimization. Creative acts generally don't stay in the context that they are in.",
      '',
      '- Alan Kay',
    },
    {
      'The essence of XML is this: the problem it solves is not hard, and it does not solve the problem well.',
      '',
      '- Phil Wadler',
    },
    {
      'A good programmer is someone who always looks both ways before crossing a one-way street.',
      '',
      '- Doug Linder',
    },
    {
      'Patterns mean "I have run out of language."',
      '',
      '- Rich Hickey',
    },
    {
      'Always code as if the person who ends up maintaining your code is a violent psychopath who knows where you live.',
      '',
      '- John Woods',
    },
    { 'Unix was not designed to stop its users from doing stupid things, as that would also stop them from doing clever things.' },
    { 'Contrary to popular belief, Unix is user friendly. It just happens to be very selective about who it decides to make friends with.' },
    { 'Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away.' },
    {
      'There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies.',
      '',
      '- C.A.R. Hoare',
    },
    { "If you don't make mistakes, you're not working on hard enough problems.", '', '- Frank Wilczek' },
    { "If you don't start with a spec, every piece of code you write is a patch.", '', '- Leslie Lamport' },
    { 'Caches are bugs waiting to happen.', '', '- Rob Pike' },
    { 'Abstraction is not about vagueness, it is about being precise at a new semantic level.', '', '- Edsger W. Dijkstra' },
    {
      "dd is horrible on purpose. It's a joke about OS/360 JCL. But today it's an internationally standardized joke. I guess that says it all.",
      '',
      '- Rob Pike',
    },
    { 'All loops are infinite ones for faulty RAM modules.' },
    {
      'All idioms must be learned. Good idioms only need to be learned once.',
      '',
      '- Alan Cooper',
    },
    {
      'For a successful technology, reality must take precedence over public relations, for Nature cannot be fooled.',
      '',
      '- Richard Feynman',
    },
    {
      'If programmers were electricians, parallel programmers would be bomb disposal experts. Both cut wires.',
      '',
      '- Bartosz Milewski',
    },
    { 'Computers are harder to maintain at high altitude. Thinner air means less cushion between disk heads and platters. Also more radiation.' },
    {
      'Almost every programming language is overrated by its practitioners.',
      '',
      '- Larry Wall',
    },
    {
      'Fancy algorithms are slow when n is small, and n is usually small.',
      '',
      '- Rob Pike',
    },
    {
      'Methods are just functions with a special first argument.',
      '',
      '- Andrew Gerrand',
    },
    {
      'Care about your craft.',
      '',
      'Why spend your life developing software unless you care about doing it well?',
    },
    {
      "Provide options, don't make lame excuses.",
      '',
      "Instead of excuses, provide options. Don't say it can't be done; explain what can be done.",
    },
    {
      'Be a catalyst for change.',
      '',
      "You can't force change on people. Instead, show them how the future might be and help them participate in creating it.",
    },
    { 'Make quality a requirements issue.', '', "Involve your users in determining the project's real quality requirements." },
    {
      'Critically analyze what you read and hear.',
      '',
      "Don't be swayed by vendors, media hype, or dogma. Analyze information in terms of you and your project.",
    },
    { "DRY - Don't Repeat Yourself.", '', 'Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.' },
    {
      'Eliminate effects between unrelated things.',
      '',
      'Design components that are self-contained, independent, and have a single, well-defined purpose.',
    },
    { 'Use tracer bullets to find the target.', '', 'Tracer bullets let you home in on your target by trying things and seeing how close they land.' },
    { 'Program close to the problem domain.', '', "Design and code in your user's language." },
    { 'Iterate the schedule with the code.', '', 'Use experience you gain as you implement to refine the project time scales.' },
    { 'Use the power of command shells.', '', "Use the shell when graphical user interfaces don't cut it." },
    { 'Always use source code control.', '', 'Source code control is a time machine for your work - you can go back.' },
    { "Don't panic when debugging", '', 'Take a deep breath and THINK! about what could be causing the bug.' },
    { "Don't assume it - prove it.", '', 'Prove your assumptions in the actual environment - with real data and boundary conditions.' },
    { 'Write code that writes code.', '', 'Code generators increase your productivity and help avoid duplication.' },
    { 'Design With contracts.', '', 'Use contracts to document and verify that code does no more and no less than it claims to do.' },
    { 'Use assertions to prevent the impossible.', '', 'Assertions validate your assumptions. Use them to protect your code from an uncertain world.' },
    {
      'Finish what you start.',
      '',
      'Where possible, the routine or object that allocates a resource should be responsible for deallocating it.',
    },
    {
      "Configure, don't integrate.",
      '',
      'Implement technology choices for an application as configuration options, not through integration or engineering.',
    },
    { 'Analyze workflow to improve concurrency.', '', "Exploit concurrency in your user's workflow." },
    { 'Always design for concurrency.', '', "Allow for concurrency, and you'll design cleaner interfaces with fewer assumptions." },
    {
      'Use blackboards to coordinate workflow.',
      '',
      'Use blackboards to coordinate disparate facts and agents, while maintaining independence and isolation among participants.',
    },
    { 'Estimate the order of your algorithms.', '', 'Get a feel for how long things are likely to take before you write code.' },
    {
      'Refactor early, refactor often.',
      '',
      'Just as you might weed and rearrange a garden, rewrite, rework, and re-architect code when it needs it. Fix the root of the problem.',
    },
    { 'Test your software, or your users will.', '', "Test ruthlessly. Don't make your users find bugs for you." },
    {
      "Don't gather requirements - dig for them.",
      '',
      "Requirements rarely lie on the surface. They're buried deep beneath layers of assumptions, misconceptions, and politics.",
    },
    {
      'Abstractions live longer than details.',
      '',
      'Invest in the abstraction, not the implementation. Abstractions can survive the barrage of changes from different implementations and new technologies.',
    },
    {
      "Don't think outside the box - find the box.",
      '',
      'When faced with an impossible problem, identify the real constraints. Ask yourself: "Does it have to be done this way? Does it have to be done at all?"',
    },
    { 'Some things are better done than described.', '', "Don't fall into the specification spiral - at some point you need to start coding." },
    {
      "Costly tools don't produce better designs.",
      '',
      'Beware of vendor hype, industry dogma, and the aura of the price tag. Judge tools on their merits.',
    },
    {
      "Don't use manual procedures.",
      '',
      'A shell script or batch file will execute the same instructions, in the same order, time after time.',
    },
    { "Coding ain't done 'til all the Tests run.", '', "'Nuff said." },
    { 'Test state coverage, not code coverage.', '', "Identify and test significant program states. Just testing lines of code isn't enough." },
    {
      'English is just a programming language.',
      '',
      'Write documents as you would write code: honor the DRY principle, use metadata, MVC, automatic generation, and so on.',
    },
    { "Gently exceed your users' expectations.", '', "Come to understand your users' expectations, then deliver just that little bit more." },
    { 'Think about your work.', '', 'Turn off the autopilot and take control. Constantly critique and appraise your work.' },
    { "Don't live with broken windows.", '', 'Fix bad designs, wrong decisions, and poor code when you see them.' },
    { 'Remember the big picture.', '', "Don't get so engrossed in the details that you forget to check what's happening around you." },
    { 'Invest regularly in your knowledge portfolio.', '', 'Make learning a habit.' },
    { "It's both what you say and the way you say it.", '', "There's no point in having great ideas if you don't communicate them effectively." },
    { 'Make it easy to reuse.', '', "If it's easy to reuse, people will. Create an environment that supports reuse." },
    {
      'There are no final decisions.',
      '',
      'No decision is cast in stone. Instead, consider each as being written in the sand at the beach, and plan for change.',
    },
    {
      'Prototype to learn.',
      '',
      'Prototyping is a learning experience. Its value lies not in the code you produce, but in the lessons you learn.',
    },
    { 'Estimate to avoid surprises.', '', "Estimate before you start. You'll spot potential problems up front." },
    { 'Keep knowledge in plain text.', '', "Plain text won't become obsolete. It helps leverage your work and simplifies debugging and testing." },
    {
      'Use a single editor well.',
      '',
      'The editor should be an extension of your hand; make sure your editor is configurable, extensible, and programmable.',
    },
    {
      'Fix the problem, not the blame.',
      '',
      "It doesn't really matter whether the bug is your fault or someone else's - it is still your problem, and it still needs to be fixed.",
    },
    {
      '"select" isn\'t broken.',
      '',
      'It is rare to find a bug in the OS or the compiler, or even a third-party product or library. The bug is most likely in the application.',
    },
    { 'Learn a text manipulation language.', '', 'You spend a large part of each day working with text. Why not have the computer do some of it for you?' },
    { "You can't write perfect software.", '', "Software can't be perfect. Protect your code and users from the inevitable errors." },
    { 'Crash early.', '', 'A dead program normally does a lot less damage than a crippled one.' },
    {
      'Use exceptions for exceptional problems.',
      '',
      'Exceptions can suffer from all the readability and maintainability problems of classic spaghetti code. Reserve exceptions for exceptional things.',
    },
    { 'Minimize coupling between modules.', '', 'Avoid coupling by writing "shy" code and applying the Law of Demeter.' },
    { 'Put abstractions in code, details in metadata.', '', 'Program for the general case, and put the specifics outside the compiled code base.' },
    {
      'Design using services.',
      '',
      'Design in terms of services-independent, concurrent objects behind well-defined, consistent interfaces.',
    },
    { 'Separate views from models.', '', 'Gain flexibility at low cost by designing your application in terms of models and views.' },
    {
      "Don't program by coincidence.",
      '',
      "Rely only on reliable things. Beware of accidental complexity, and don't confuse a happy coincidence with a purposeful plan.",
    },
    { 'Test your estimates.', '', "Mathematical analysis of algorithms doesn't tell you everything. Try timing your code in its target environment." },
    { 'Design to test.', '', 'Start thinking about testing before you write a line of code.' },
    {
      "Don't use wizard code you don't understand.",
      '',
      'Wizards can generate reams of code. Make sure you understand all of it before you incorporate it into your project.',
    },
    { 'Work with a user to think like a user.', '', "It's the best way to gain insight into how the system will really be used." },
    { 'Use a project glossary.', '', 'Create and maintain a single source of all the specific terms and vocabulary for a project.' },
    { "Start when you're ready.", '', "You've been building experience all your life. Don't ignore niggling doubts." },
    {
      "Don't be a slave to formal methods.",
      '',
      "Don't blindly adopt any technique without putting it into the context of your development practices and capabilities.",
    },
    {
      'Organize teams around functionality.',
      '',
      "Don't separate designers from coders, testers from data modelers. Build teams the way you build code.",
    },
    { 'Test early. Test often. Test automatically.', '', 'Tests that run with every build are much more effective than test plans that sit on a shelf.' },
    {
      'Use saboteurs to test your testing.',
      '',
      'Introduce bugs on purpose in a separate copy of the source to verify that testing will catch them.',
    },
    {
      'Find bugs once.',
      '',
      'Once a human tester finds a bug, it should be the last time a human tester finds that bug. Automatic tests should check for it from then on.',
    },
    {
      'Sign your work.',
      '',
      'Craftsmen of an earlier age were proud to sign their work. You should be, too.',
    },
    { 'Think twice, code once.' },
    { 'No matter how far down the wrong road you have gone, turn back now.' },
    { 'Why do we never have time to do it right, but always have time to do it over?' },
    { 'Weeks of programming can save you hours of planning.' },
    { 'To iterate is human, to recurse divine.', '', '- L. Peter Deutsch' },
    { 'Computers are useless. They can only give you answers.', '', '- Pablo Picasso' },
    { 'The question of whether computers can think is like the question of whether submarines can swim.', '', '- Edsger W. Dijkstra' },
    {
      "It's ridiculous to live 100 years and only be able to remember 30 million bytes. You know, less than a compact disc. The human condition is really becoming more obsolete every minute.",
      '',
      '- Marvin Minsky',
    },
    { "The city's central computer told you? R2D2, you know better than to trust a strange computer!", '', '- C3PO' },
    {
      'Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves.',
      '',
      '- Alan Kay',
    },
    { 'I\'ve finally learned what "upward compatible" means. It means we get to keep all our old mistakes.', '', '- Dennie van Tassel' },
    { "There are two major products that come out of Berkeley: LSD and UNIX. We don't believe this to be a coincidence.", '', '- Jeremy S. Anderson' },
    {
      "The bulk of all patents are crap. Spending time reading them is stupid. It's up to the patent owner to do so, and to enforce them.",
      '',
      '- Linus Torvalds',
    },
    { 'Controlling complexity is the essence of computer programming.', '', '- Brian Kernighan' },
    {
      'Complexity kills. It sucks the life out of developers, it makes products difficult to plan, build and test, it introduces security challenges, and it causes end-user and administrator frustration.',
      '',
      '- Ray Ozzie',
    },
    { 'The function of good software is to make the complex appear to be simple.', '', '- Grady Booch' },
    {
      "There's an old story about the person who wished his computer were as easy to use as his telephone. That wish has come true, since I no longer know how to use my telephone.",
      '',
      '- Bjarne Stroustrup',
    },
    { 'There are only two industries that refer to their customers as "users".', '', '- Edward Tufte' },
    { 'Most of you are familiar with the virtues of a programmer. There are three, of course: laziness, impatience, and hubris.', '', '- Larry Wall' },
    {
      'Computer science education cannot make anybody an expert programmer any more than studying brushes and pigment can make somebody an expert painter.',
      '',
      '- Eric S. Raymond',
    },
    { 'Optimism is an occupational hazard of programming; feedback is the treatment.', '', '- Kent Beck' },
    { 'First, solve the problem. Then, write the code.', '', '- John Johnson' },
    { 'Measuring programming progress by lines of code is like measuring aircraft building progress by weight.', '', '- Bill Gates' },
    {
      "Don't worry if it doesn't work right. If everything did, you'd be out of a job.",
      '',
      "- Mosher's Law of Software Engineering",
    },
    { 'A LISP programmer knows the value of everything, but the cost of nothing.', '', '- Alan J. Perlis' },
    { 'All problems in computer science can be solved with another level of indirection.', '', '- David Wheeler' },
    { 'Functions delay binding; data structures induce binding. Moral: Structure data late in the programming process.', '', '- Alan J. Perlis' },
    { 'Easy things should be easy and hard things should be possible.', '', '- Larry Wall' },
    { 'Nothing is more permanent than a temporary solution.' },
    { "If you can't explain something to a six-year-old, you really don't understand it yourself.", '', '- Albert Einstein' },
    { 'All programming is an exercise in caching.', '', '- Terje Mathisen' },
    { 'Software is hard.', '', '- Donald Knuth' },
    { 'They did not know it was impossible, so they did it!', '', '- Mark Twain' },
    {
      'The object-oriented model makes it easy to build up programs by accretion. What this often means, in practice, is that it provides a structured way to write spaghetti code.',
      '',
      '- Paul Graham',
    },
    {
      'Question: How does a large software project get to be one year late?',
      'Answer: One day at a time!',
    },
    {
      'The first 90% of the code accounts for the first 90% of the development time. The remaining 10% of the code accounts for the other 90% of the development time.',
      '',
      '- Tom Cargill',
    },
    {
      "In software, we rarely have meaningful requirements. Even if we do, the only measure of success that matters is whether our solution solves the customer's shifting idea of what their problem is.",
      '',
      '- Jeff Atwood',
    },
    {
      'If debugging is the process of removing bugs, then programming must be the process of putting them in.',
      '',
      '- Edsger W. Dijkstra',
    },
    {
      '640K ought to be enough for anybody.',
      '',
      '- Bill Gates, 1981',
    },
    {
      'To understand recursion, one must first understand recursion.',
      '',
      '- Stephen Hawking',
    },
    {
      'Developing tolerance for imperfection is the key factor in turning chronic starters into consistent finishers.',
      '',
      '- Jon Acuff',
    },
    {
      'Every great developer you know got there by solving problems they were unqualified to solve until they actually did it.',
      '',
      '- Patrick McKenzie',
    },
    {
      "The average user doesn't give a damn what happens, as long as (1) it works and (2) it's fast.",
      '',
      '- Daniel J. Bernstein',
    },
    {
      'Walking on water and developing software from a specification are easy if both are frozen.',
      '',
      '- Edward V. Berard',
    },
    {
      'Be curious. Read widely. Try new things. I think a lot of what people call intelligence boils down to curiosity.',
      '',
      '- Aaron Swartz',
    },
    {
      'What one programmer can do in one month, two programmers can do in two months.',
      '',
      '- Frederick P. Brooks',
    },
  },
}
dashboard.section.footer.val = fortune(options)

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd [[
autocmd FileType alpha setlocal nofoldenable
]]

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- Telescope setup, keymaps, LSP picker mappings
-- ============================================================
do
  -- [[ Fuzzy Finder (files, lsp, etc) ]]
  --
  -- Telescope is a fuzzy finder that comes with a lot of different things that
  -- it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- There are lots of other alternative pickers (like snacks.picker, or fzf-lua)
  -- so feel free to experiment and see what you like!
  --
  -- The easiest way to use Telescope, is to start by doing something like:
  --  :Telescope help_tags
  --
  -- After running this command, a window will open up and you're able to
  -- type in the prompt window. You'll see a list of `help_tags` options and
  -- a corresponding preview of the help.
  --
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Telescope picker. This is really useful to discover what Telescope can
  -- do as well as how to actually do it!

  ---@type (string|vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
  }
  if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

  -- NOTE: You can install multiple plugins at once
  vim.pack.add(telescope_plugins)

  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
  -- If you later switch picker plugins, this is where to update these mappings.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      -- Find references for the word under your cursor.
      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

      -- Jump to the implementation of the word under your cursor.
      -- Useful when your language has ways of declaring types without an actual implementation.
      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

      -- Jump to the definition of the word under your cursor.
      -- This is where a variable was first declared, or where a function is defined, etc.
      -- To jump back, press <C-t>.
      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

      -- Fuzzy find all the symbols in your current document.
      -- Symbols are things like variables, functions, types, etc.
      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

      -- Fuzzy find all the symbols in your current workspace.
      -- Similar to document symbols, except searches over your entire project.
      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

      -- Jump to the type of the word under your cursor.
      -- Useful when you're not sure what type a variable is and you want to see
      -- the definition of its *type*, not where it was *defined*.
      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
    end,
  })

  -- Override default behavior and theme when searching
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    { desc = '[S]earch [/] in Open Files' }
  )

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[S]earch [N]eovim files' })
end

-- ============================================================
-- SECTION 6: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
  -- [[ LSP Configuration ]]
  -- Brief aside: **What is LSP?**
  --
  -- LSP is an initialism you've probably heard, but might not understand what it is.
  --
  -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  -- and language tooling communicate in a standardized fashion.
  --
  -- In general, you have a "server" which is some tool built to understand a particular
  -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  -- processes that communicate with some "client" - in this case, Neovim!
  --
  -- LSP provides Neovim with features like:
  --  - Go to definition
  --  - Find references
  --  - Autocompletion
  --  - Symbol Search
  --  - and more!
  --
  -- Thus, Language Servers are external tools that must be installed separately from
  -- Neovim. This is where `mason` and related plugins come into play.
  --
  -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  -- and elegantly composed help section, `:help lsp-vs-treesitter`

  -- Useful status updates for LSP.
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}

  --  This function gets run when an LSP attaches to a particular buffer.
  --    That is to say, every time a new file is opened that is associated with
  --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --    function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  See `:help lsp-config` for information about keys and how to configure
  ---@type table<string, vim.lsp.Config>
  local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    rust_analyzer = {},
    --
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- But for many setups, the LSP (`ts_ls`) will work just fine
    ts_ls = {},

    stylua = {}, -- Used to format Lua code

    -- Special Lua Config, as recommended by neovim help docs
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
        client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.api.nvim_get_runtime_file('', true),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false }, -- Disable formatting (formatting is done by stylua)
        },
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- Automatically install LSPs and related tools to stdpath for Neovim
  require('mason').setup {}

  -- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
  require('mason-lspconfig').setup {
    automatic_enable = false, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
  }

  -- Ensure the servers and tools above are installed
  --
  -- To check the current status of installed tools and/or manually install
  -- other tools, you can run
  --    :Mason
  --
  -- You can press `g?` for help in this menu.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- You can add other tools here that you want Mason to install
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

-- ============================================================
-- SECTION 7: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
do
  -- [[ Formatting ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        -- lua = true,
        -- python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      -- rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
end

-- ============================================================
-- SECTION 8: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================
do
  -- [[ Snippet Engine ]]

  -- NOTE: You can also specify plugin using a version range for its git tag.
  --  See `:help vim.version.range()` for more info
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  -- `friendly-snippets` contains a variety of premade snippets.
  --    See the README about individual language/framework/plugin snippets:
  --    https://github.com/rafamadriz/friendly-snippets
  --
  -- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
  -- require('luasnip.loaders.from_vscode').lazy_load()

  -- [[ Autocomplete Engine ]]
  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See `:help blink-cmp-config-keymap` for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See `:help blink-cmp-config-fuzzy` for more information
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  }
end

-- ============================================================
-- SECTION 9: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
  -- [[ Configure Treesitter ]]
  --  Used to highlight, edit, and navigate code
  --
  --  See `:help nvim-treesitter-intro`

  -- NOTE: You can also specify a branch or a specific commit
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  -- Ensure basic parsers are installed
  local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then return end
    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- Enable treesitter based folds
    -- For more info on folds see `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- Check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- Enable treesitter based indentation
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        -- Enable the parser if it is already installed
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- ============================================================
-- SECTION 10: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug'
  -- require 'kickstart.plugins.indent_line'
  -- require 'kickstart.plugins.lint'
  -- require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'
  -- require 'kickstart.plugins.gitsigns' -- adds gitsigns recommended keymaps

  -- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- require 'custom.plugins'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
