#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/clangd"
CONFIG_FILE="$CONFIG_DIR/config.yaml"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Selector de Estándar C++ (clangd)   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Mostrar estándar actual
if [ -f "$CONFIG_FILE" ]; then
    CURRENT_STD=$(grep -oP '(?<=-std=c\+\+)\d+' "$CONFIG_FILE" 2>/dev/null)
    if [ -n "$CURRENT_STD" ]; then
        echo -e "${GREEN}📌 Estándar actual: C++${CURRENT_STD}${NC}"
    else
        echo -e "${YELLOW}⚠️  No hay estándar configurado${NC}"
    fi
    echo ""
fi

# Menú
echo -e "${YELLOW}Selecciona el estándar de C++:${NC}"
echo ""
echo "  1) C++11"
echo "  2) C++14"
echo "  3) C++17"
echo "  4) C++20 ${GREEN}(Recomendado)${NC}"
echo "  5) C++23 ${BLUE}(Más reciente)${NC}"
echo ""
echo "  0) Cancelar"
echo ""
read -p "Opción: " choice

case $choice in
    1) STANDARD="c++11" ;;
    2) STANDARD="c++14" ;;
    3) STANDARD="c++17" ;;
    4) STANDARD="c++20" ;;
    5) STANDARD="c++23" ;;
    0)
        echo -e "\n${YELLOW}Cancelado${NC}"
        echo ""
        echo "Enter para cerrar..."
        read
        exit 0
        ;;
    *)
        echo -e "\n${RED}✗ Opción inválida${NC}"
        echo ""
        echo "Enter para cerrar..."
        read
        exit 1
        ;;
esac

# Crear directorio si no existe
mkdir -p "$CONFIG_DIR"

# Crear configuración
cat > "$CONFIG_FILE" << EOF
CompileFlags:
  Add:
    - -std=$STANDARD
    - -Wall
    - -Wextra
EOF

echo ""
echo -e "${GREEN}✓ Configuración actualizada${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Estándar: ${GREEN}${STANDARD}${NC}"
echo -e "Archivo: ${BLUE}$CONFIG_FILE${NC}"
echo ""
echo -e "${YELLOW}Reinicia LSP con :LspRestart${NC}"
echo ""
echo "Enter para cerrar..."
read
