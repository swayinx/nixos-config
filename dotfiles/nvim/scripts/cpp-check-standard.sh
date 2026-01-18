#!/usr/bin/env bash
#wohoho
#wahaha
#comenatario pa ver si se copia todo xd
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

clear
echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Diagnóstico de Estándar C++ (clangd)   ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo ""

# Directorio actual
echo -e "${YELLOW}📁 Directorio actual:${NC}"
echo "   $(pwd)"
echo ""

# Configuración global
echo -e "${YELLOW}🌐 Configuración global:${NC}"
if [ -f "$HOME/.config/clangd/config.yaml" ]; then
    STD=$(grep -oP '(?<=-std=c\+\+)\w+' "$HOME/.config/clangd/config.yaml")
    echo -e "   ${GREEN}✓${NC} ~/.config/clangd/config.yaml"
    echo -e "   ${GREEN}Standard: C++${STD}${NC}"
else
    echo -e "   ${RED}✗${NC} No existe configuración global"
fi
echo ""

# Buscar .clangd local
echo -e "${YELLOW}📂 Configuración local (.clangd):${NC}"
FOUND=0
DIR="$(pwd)"
while [ "$DIR" != "/" ]; do
    if [ -f "$DIR/.clangd" ]; then
        STD=$(grep -oP '(?<=-std=c\+\+)\w+' "$DIR/.clangd")
        echo -e "   ${GREEN}✓${NC} Encontrado en: $DIR/.clangd"
        echo -e "   ${BLUE}Standard: C++${STD}${NC}"
        echo -e "   ${RED}⚠️  Esta configuración sobrescribe la global${NC}"
        FOUND=1
        break
    fi
    DIR=$(dirname "$DIR")
done

if [ $FOUND -eq 0 ]; then
    echo -e "   ${YELLOW}○${NC} No hay .clangd local (usando config global)"
fi
echo ""

# Buscar compile_commands.json
echo -e "${YELLOW}🔨 compile_commands.json:${NC}"
if [ -f "compile_commands.json" ]; then
    echo -e "   ${GREEN}✓${NC} Encontrado en carpeta actual"
    echo -e "   ${RED}⚠️  Este archivo puede sobrescribir configuraciones${NC}"
else
    echo -e "   ${YELLOW}○${NC} No existe (esto es normal)"
fi
echo ""

# Verificar clangd
echo -e "${YELLOW}🔧 clangd:${NC}"
if command -v clangd &> /dev/null; then
    VERSION=$(clangd --version | head -n1)
    echo -e "   ${GREEN}✓${NC} $VERSION"
else
    echo -e "   ${RED}✗${NC} clangd no encontrado"
fi
echo ""

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Resumen:${NC}"

if [ $FOUND -eq 1 ]; then
    echo -e "  • Este proyecto usa: ${BLUE}C++${STD}${NC} (configuración local)"
else
    if [ -f "$HOME/.config/clangd/config.yaml" ]; then
        STD=$(grep -oP '(?<=-std=c\+\+)\w+' "$HOME/.config/clangd/config.yaml")
        echo -e "  • Este proyecto usa: ${GREEN}C++${STD}${NC} (configuración global)"
    else
        echo -e "  • Este proyecto usa: ${YELLOW}Default del sistema${NC}"
    fi
fi

echo ""
echo "Enter para cerrar..."
read
