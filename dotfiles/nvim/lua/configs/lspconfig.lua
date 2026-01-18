require("nvchad.configs.lspconfig").defaults()
local nvlsp = require "nvchad.configs.lspconfig"

-- ============================================
-- CONFIGURACIÓN DE DIAGNÓSTICOS EN TIEMPO REAL
-- ============================================
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = " ",
    }
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

-- ============================================
-- ICONOS BONITOS PARA DIAGNÓSTICOS
-- ============================================
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = " ",
    }
  }
})-- ============================================
-- SERVIDORES LSP
-- ============================================
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "tailwindcss",
  "emmet_ls",
  "pyright",
  "lua_ls",
  "gopls",
  "rust_analyzer",
  "clangd",
  "jsonls",
  "yamlls",
  "bashls",
}

-- Configuración especial para lua_ls
vim.lsp.config("lua_ls", {
  capabilities = nvlsp.capabilities,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- Configuración especial para clangd con C++20
vim.lsp.config("clangd", {
  capabilities = nvlsp.capabilities,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  init_options = {
    fallbackFlags = { "-std=c++20" },
  },
})

-- Configurar el resto de servidores
for _, server in ipairs(servers) do
  if server ~= "lua_ls" and server ~= "clangd" then
    vim.lsp.config(server, {
      capabilities = nvlsp.capabilities,
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
    })
  end
end

-- Habilitar todos los servidores
vim.lsp.enable(servers)
