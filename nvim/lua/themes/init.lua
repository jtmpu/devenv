local name = "onedark"

-- Check if there's a colorscheme configuration
pcall(require, "themes." .. name)

local theme_ok = pcall(vim.cmd.colorscheme, name)
if not theme_ok then
  vim.cmd.colorscheme "habamax"
  return vim.notify("\nFailed to load colorscheme " .. name .. "\nUse habamax instead", vim.log.levels.ERROR)
else
  -- Load colorscheme
  vim.cmd.colorscheme(name)
end
