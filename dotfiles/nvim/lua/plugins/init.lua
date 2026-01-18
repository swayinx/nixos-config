return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Trouble.nvim - Visor de diagnósticos
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {},
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
    },
  },

  -- LSP Saga - UI mejorada para LSP
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "rounded",
          code_action = "",
        },
        lightbulb = {
          enable = true,
          sign = true,
          virtual_text = false,
        },
      })
    end,
  },

  -- Treesitter - Syntax highlighting mejorado
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "python",
        "json",
        "markdown",
        "bash",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },

-- Añade esto al final de: ~/.config/nvim/lua/plugins/init.lua

{
  "next-file",
  dir = "~/.config/nvim", -- Plugin local
  event = "VeryLazy",
  config = function()
    vim.api.nvim_create_user_command('Nx', function()
      local file = vim.fn.expand('%:t')
      local dir = vim.fn.expand('%:p:h')
      local ext = vim.fn.expand('%:e')

      if file == '' then
        return vim.notify('No hay archivo abierto', vim.log.levels.ERROR)
      end

      local prefix, num = file:match('^([%a]+)(%d+)%.')

      if not prefix then
        return vim.notify('Sin patrón numérico en: ' .. file, vim.log.levels.ERROR)
      end

      local digits = #num
      local curr = tonumber(num)

      local function name(n)
        return prefix .. string.format('%0' .. digits .. 'd', n) .. '.' .. ext
      end

      local next = curr + 1
      while vim.fn.filereadable(dir .. '/' .. name(next)) == 1 do
        next = next + 1
        if next > curr + 1000 then
          return vim.notify('Sin número disponible', vim.log.levels.ERROR)
        end
      end

      vim.cmd('edit ' .. dir .. '/' .. name(next))
      vim.notify('✓ Creado: ' .. name(next), vim.log.levels.INFO)
    end, { desc = 'Crear siguiente archivo numerado' })
  end,
},
}
