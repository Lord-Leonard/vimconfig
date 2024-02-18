local settingsPath = os.getenv("localappdata") ..
    "\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\\settings.json"

local settingsPathNew = os.getenv("localappdata") ..
    "\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\\settingsnew.json"

function GoColorYourself(color)
  -- color = color or GetColor()
  color = color or GetColor()

  local settings = io.open(
    settingsPath,
    "r"
  )
  if (settings == nil or settings == "") then
    vim.cmd.colorscheme(color)
    return
  end

  local updatedSettings = {}
  for line in settings:lines() do
    if string.find(line, "\"theme\":") then
      line = "    \"theme\": \"" .. color .. "\","
    elseif string.find(line, "\"colorScheme\":") then
      line = "            \"colorScheme\": \"" .. color .. "\","
    end

    table.insert(updatedSettings, line)
  end
  io.close(settings)


  settings = io.open(
    settingsPathNew,
    "w"
  )
  if (settings == nil or settings == "") then
    vim.cmd.colorscheme(color)
    return
  end

  for _, value in ipairs(updatedSettings) do
    settings:write(value .. "\n")
  end
  io.close(settings)

  os.remove(settingsPath)
  os.rename(settingsPathNew, settingsPath)

  vim.cmd.colorscheme(color)

  --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

CurrentFlavor = {
  dark = "catppuccin-frappe",
  light = "catppuccin-latte"
}


function GetColor()
  local currentTime = os.date("*t", os.time())
  if (currentTime.hour < 6 or currentTime.hour > 18) then
    return CurrentFlavor.dark
  else
    return CurrentFlavor.light
  end
end

return {
  {
    "folke/tokyonight.nvim",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
      require("catppuccin").setup({
        falvor = "latte",
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          mason = true
        }
      })
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        variant = "dawn", -- auto, main, moon, or dawn

        -- disable_background = true,

        highlight_groups = {
          StatusLine = { fg = "love", bg = "love", blend = 10 },
          StatusLineNC = { fg = "subtle", bg = "surface" },
        },
      })

      GoColorYourself()
    end
  },
}
