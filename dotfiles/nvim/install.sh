#!/usr/bin/env bash

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔧 Iniciando configuración de Neovim...${NC}"

# 1. Dar permisos a scripts
echo -e "📂 Asignando permisos a scripts..."
chmod +x scripts/*.sh
echo -e "${GREEN}✓ Scripts ejecutables${NC}"

# 2. Instalar Lazy.nvim (Bootstrap manual)
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
  echo -e "📦 Clonando lazy.nvim..."
  mkdir -p "$HOME/.local/share/nvim/lazy"
  git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$LAZY_PATH"
  echo -e "${GREEN}✓ Lazy instalado${NC}"
else
  echo -e "${GREEN}✓ Lazy ya estaba instalado${NC}"
fi

# 3. Aviso final
echo ""
echo -e "${GREEN}✨ ¡Instalación completa!${NC}"
echo -e "Ahora abre nvim y espera a que se instalen los plugins."
