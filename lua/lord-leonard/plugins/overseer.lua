return {
  'stevearc/overseer.nvim',
  opts = {},
  keys = {
    { "<leader>ot", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
    { "<leader>oo", "<cmd>OverseerRun<cr>",         desc = "Run task" },
    { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
    { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
    { "<leader>ob", "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
    { "<leader>oa", "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
    { "<leader>oc", "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
  },
}
