#!/usr/bin/env bash
# Script para aplicar la configuración de NixOS

# Entrar a la carpeta de la config
pushd ~/nixos-config > /dev/null

# Aplicar los cambios
echo "🚀 Aplicando cambios de NixOS..."
sudo nixos-rebuild switch --flake .#nixos

# Regresar a donde estábamos
popd > /dev/null
