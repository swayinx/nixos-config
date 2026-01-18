local function flash(msg, hl)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { msg })
  local width = math.max(20, #msg + 4)
  local opts = {
    relative = "editor",
    style = "minimal",
    width = width,
    height = 1,
    row = math.floor((vim.o.lines - 1) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = "rounded",
    noautocmd = true,
  }
  local win = vim.api.nvim_open_win(buf, false, opts)
  vim.api.nvim_set_option_value("winhl", "Normal:" .. hl .. ",FloatBorder:" .. hl, { win = win })
  vim.api.nvim_win_set_option(win, "winblend", 10)
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, 1200)
end

vim.api.nvim_create_user_command('Nx', function()
  local file = vim.fn.expand('%:t')
  local dir = vim.fn.expand('%:p:h')
  local ext = vim.fn.expand('%:e')

  if file == '' then
    return flash('No hay archivo abierto', 'ErrorMsg')
  end

  local prefix, num = file:match('^([%a]+)(%d+)%.')

  if not prefix then
    return flash('Sin patrón numérico en: ' .. file, 'ErrorMsg')
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
      return flash('Sin número disponible', 'ErrorMsg')
    end
  end

  vim.cmd('edit ' .. dir .. '/' .. name(next))
  flash('✓ Creado: ' .. name(next), 'MoreMsg')
end, { desc = 'Crear siguiente archivo numerado' })
