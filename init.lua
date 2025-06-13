-- Setup branch-based plugin isolation BEFORE loading any plugins
require("config.branch-isolation").setup()

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
