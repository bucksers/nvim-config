-- Branch-based plugin isolation for multi-config Neovim setup
-- This module automatically configures separate data directories based on git branch
-- allowing different plugins and configurations per branch

local M = {}

function M.setup()
  local handle = io.popen("cd " .. vim.fn.stdpath("config") .. " && git branch --show-current 2>/dev/null")
  if not handle then
    return
  end
  
  local branch = handle:read("*l")
  handle:close()
  
  -- Only isolate non-main branches
  if not branch or branch == "" or branch == "main" then
    return
  end
  
  -- Use branch-specific data directory for complete isolation
  local data_dir = vim.fn.stdpath("data") .. "-" .. branch
  local state_dir = vim.fn.stdpath("state"):gsub("nvim", "nvim-" .. branch)
  local cache_dir = vim.fn.stdpath("cache"):gsub("nvim", "nvim-" .. branch)
  
  -- Create the directories
  vim.fn.mkdir(data_dir, "p")
  vim.fn.mkdir(state_dir, "p")
  vim.fn.mkdir(cache_dir, "p")
  
  -- Override standard paths to use branch-specific directories
  vim.env.XDG_DATA_HOME = data_dir
  vim.env.XDG_STATE_HOME = state_dir
  vim.env.XDG_CACHE_HOME = cache_dir
  
  -- Optional: Print current branch for debugging
  if vim.env.DEBUG_BRANCH_ISOLATION then
    print("Branch isolation active: " .. branch)
    print("Data dir: " .. data_dir)
  end
end

return M
