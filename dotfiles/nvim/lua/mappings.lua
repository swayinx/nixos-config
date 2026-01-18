require "nvchad.mappings"
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Verificar estándar C++ actual
map("n", "<leader>cc", function()
  local script = vim.fn.stdpath("config") .. "/scripts/cpp-check-standard.sh"
  vim.cmd("split | terminal " .. script)
  vim.cmd("startinsert")
end, { desc = "Check C++ Standard" })

-- Selector de estándar C++ (similar a tu runner)
map("n", "<leader>cs", function()
  local script = vim.fn.stdpath("config") .. "/scripts/cpp-standard.sh"
  vim.cmd("split | terminal " .. script)
  vim.cmd("startinsert")
end, { desc = "C++ Standard Selector" })



-- Compilar y ejecutar código en nueva terminal Kitty
map("n", "<leader>r", function()
  -- Guardar el archivo actual
  vim.cmd("write")
  
  -- Obtener la ruta completa del archivo actual
  local file_path = vim.fn.expand("%:p")
  
  -- Verificar que el archivo tenga una extensión válida
  local extension = vim.fn.expand("%:e")
  local valid_extensions = { "c", "cpp", "cc", "cxx", "py", "rs", "sh", "bash", "js", "java" }
  local is_valid = false
  
  for _, ext in ipairs(valid_extensions) do
    if extension == ext then
      is_valid = true
      break
    end
  end
  
  if not is_valid then
    print("✗ Tipo no soportado: ." .. extension)
    return
  end
  
  -- Comando para abrir Kitty y ejecutar el script
  local script_path = vim.fn.stdpath("config") .. "/scripts/run.sh"
  local cmd = string.format("kitty --hold sh -c '%s \"%s\"' &", script_path, file_path)
  
  -- Ejecutar el comando
  vim.fn.system(cmd)
  print("Ejecutando en nueva terminal...")
end, { desc = "Guardar, compilar y ejecutar en Kitty" })

-- Popear: compilar y ejecutar con inputs de archivos
map("n", "<leader>p", function()
  -- Guardar el archivo actual
  vim.cmd("write")
  
  -- Obtener la ruta completa del archivo actual
  local file_path = vim.fn.expand("%:p")
  
  -- Verificar que el archivo tenga una extensión válida
  local extension = vim.fn.expand("%:e")
  local valid_extensions = { "c", "cpp", "cc", "cxx", "py", "rs", "sh", "bash", "js", "java" }
  local is_valid = false
  
  for _, ext in ipairs(valid_extensions) do
    if extension == ext then
      is_valid = true
      break
    end
  end
  
  if not is_valid then
    print("✗ Tipo no soportado: ." .. extension)
    return
  end
  
  -- Comando para abrir Kitty y ejecutar el script de popear
  local script_path = vim.fn.stdpath("config") .. "/scripts/popear.sh"
  local cmd = string.format("kitty sh -c '%s \"%s\"' &", script_path, file_path)
  
  -- Ejecutar el comando
  vim.fn.system(cmd)
  print("Popeando en nueva terminal...")
end, { desc = "Popear: ejecutar con inputs" })
