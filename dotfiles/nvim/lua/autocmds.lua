require "nvchad.autocmds"

-- ============================================
-- TEMPLATES PARA C Y C++
-- ============================================

local autocmd = vim.api.nvim_create_autocmd

-- Template para C++
autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    local lines = {
      "#include <iostream>",
      "using namespace std;",
      "",
      "int main(){",
      "    ",
      "    ",
      "    ",
      "    ",
      "    return 0;",
      "}"
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    -- Posicionar cursor en línea 5, columna 4
    vim.api.nvim_win_set_cursor(0, {5, 5})
    vim.cmd("startinsert!")
  end,
})

-- Template para C
autocmd("BufNewFile", {
  pattern = "*.c",
  callback = function()
    local lines = {
      "#include <stdio.h>",
      "",
      "int main(){",
      "    ",
      "    ",
      "    ",
      "    ",
      "    return 0;",
      "}"
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    -- Posicionar cursor en línea 4, columna 4
    vim.api.nvim_win_set_cursor(0, {4, 5})
    vim.cmd("startinsert!")
  end,
})

-- Forzar wrap después de que cargue todo
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})
