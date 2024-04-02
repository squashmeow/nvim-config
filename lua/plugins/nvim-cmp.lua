-- nvim-cmp is a plugin that integrate different source code competion source
return {

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "zbirenbaum/copilot-cmp",
      "onsails/lspkind-nvim",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(
        { { name = "nvim_lsp" }, { name = "buffer" }, { name = "path" }, { name = "copilot" } },
        { { name = "emoji" } }
        --- add new sources below
      )
      opts.formatting = {
        fields = { "abbr", "kind", "menu" },
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          max_width = 50,
          symbol_map = { Copilot = "" },
          before = function(entry, vim_item)
            local kind = vim_item.kind
            vim_item.kind = require("lspkind").symbol_map[kind] or "?"
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              path = "[Path]",
              emoji = "[Emoji]",
              copilot = "[Copilot]",
            })[entry.source.name]
            return vim_item
          end,
        }),
      }
    end,
  },
}

-- the cmp.config.sources function's definition from https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/sources.lua
-- the function flaten the group of sources, but assign the same gourp_index value to source within the same group
--[[
return function(...)
  local sources = {}
  for i, group in ipairs({ ... }) do
    for _, source in ipairs(group) do
      source.group_index = i
      table.insert(sources, source)
    end
  end
  return sources
end ]]
--
