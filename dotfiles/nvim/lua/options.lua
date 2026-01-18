require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
-- 

require "nvchad.options"


-- Opciones personalizadas
local o = vim.o
local opt = vim.opt

-- ============================================
-- INDENTACIÓN
-- ============================================
o.tabstop = 4           -- Ancho visual de un tab (4 espacios)
o.shiftwidth = 4        -- Espacios para indentación automática
o.softtabstop = 4       -- Espacios al presionar Tab
o.expandtab = true      -- Convertir tabs a espacios
o.smartindent = true    -- Indentación inteligente
o.autoindent = true     -- Mantener indentación de línea anterior

-- ============================================
-- NÚMEROS DE LÍNEA
-- ============================================
o.number = true         -- Mostrar números de línea
o.relativenumber = true -- Números relativos (útil para movimientos)
o.numberwidth = 2       -- Ancho de la columna de números

-- ============================================
-- BÚSQUEDA
-- ============================================
o.ignorecase = true     -- Ignorar mayúsculas al buscar
o.smartcase = true      -- Sensible a mayúsculas si usas mayúsculas
o.hlsearch = true       -- Resaltar resultados de búsqueda
o.incsearch = true      -- Búsqueda incremental

-- ============================================
-- APARIENCIA
-- ============================================
o.cursorline = true     -- Resaltar línea actual
o.cursorlineopt = 'both' -- Resaltar línea y número
o.termguicolors = true  -- Colores verdaderos
o.signcolumn = "yes"    -- Siempre mostrar columna de signos (git, errores)
o.wrap = false          -- No dividir líneas largas
o.scrolloff = 8         -- Líneas mínimas arriba/abajo del cursor
o.sidescrolloff = 8     -- Columnas mínimas a los lados

-- ============================================
-- COMPORTAMIENTO
-- ============================================
o.mouse = "a"           -- Habilitar mouse en todos los modos
o.clipboard = "unnamedplus" -- Usar clipboard del sistema
o.undofile = true       -- Guardar historial de deshacer
o.swapfile = false      -- No crear archivos .swp
o.backup = false        -- No crear backups
o.updatetime = 250      -- Tiempo para guardar swap/mostrar diagnósticos
o.timeoutlen = 300      -- Tiempo de espera para secuencias de teclas

-- ============================================
-- SPLITS (DIVISIONES DE VENTANA)
-- ============================================
o.splitbelow = true     -- Split horizontal hacia abajo
o.splitright = true     -- Split vertical a la derecha

-- ============================================
-- AUTOCOMPLETADO
-- ============================================
o.completeopt = "menuone,noselect" -- Mejor experiencia de autocompletado
o.pumheight = 10        -- Altura del menú de autocompletado

-- ============================================
-- FORMATO DE ARCHIVOS
-- ============================================
o.fileencoding = "utf-8"      -- Encoding
o.conceallevel = 0            -- Ver `` en markdown

-- ============================================
-- OTRAS ÚTILES
-- ============================================
o.showmode = false      -- No mostrar modo (ya lo muestra la statusline)
o.showcmd = true        -- Mostrar comando parcial
o.cmdheight = 1         -- Altura de la línea de comandos
o.ruler = true          -- Mostrar posición del cursor
o.hidden = true         -- Mantener buffers abiertos en segundo plano
o.errorbells = false    -- Sin campanas de error
