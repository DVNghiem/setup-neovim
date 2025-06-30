-- Set leader key early to avoid warnings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Early notification setup to prevent compatibility issues
local function setup_early_notify()
  -- Temporary safe notify function until nvim-notify loads
  local function safe_notify(msg, level, opts)
    if type(msg) ~= "string" then msg = tostring(msg or "") end
    if type(level) ~= "number" then level = vim.log.levels.INFO end
    if type(opts) == "string" then opts = { title = opts } end
    if type(opts) ~= "table" then opts = {} end
    
    -- Use basic print until nvim-notify is loaded
    local level_str = level == vim.log.levels.ERROR and "ERROR" or 
                     level == vim.log.levels.WARN and "WARN" or "INFO"
    print(string.format("[%s] %s", level_str, msg))
  end
  
  -- Set temporary notify function
  vim.notify = safe_notify
end

setup_early_notify()

require("config.lazy")
require("config.cores")