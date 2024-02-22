vim.opt.nu = true
vim.opt.relativenumber = true


-- clipboard
-- !!! when using ssl you need VcXsrv to sync linux and windows clipboard.
-- !!! see https://medium.com/@awlucattini_60867/getting-started-with-wsl2-c11826654776 for more info.
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("localappdata") .. "/nvim-data/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- append path for node 20 to PATH so that all the lsps can start ...
local node_path = os.getenv("appdata") .. "\\nvm\\v20.11.0;"
vim.env.PATH = node_path .. vim.env.PATH


-- enable tab title
vim.opt.title = true
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    -- use this if you want - cwd 
    -- [[%t – %{fnamemodify(getcwd(), ':t')}]] 

    vim.opt.titlestring = [[%t]]
    print("vim.opt.titlestring")
  end
})


-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd[[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]]

