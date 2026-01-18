{ config, pkgs, inputs, ... }:

{
  home.username = "chris";
  home.homeDirectory = "/home/chris";

  # Versión del estado de home-manager (no cambiar a menos que sepas qué haces)
  home.stateVersion = "24.11"; 




  # ----------Paquetes específicos del usuario-------------
  home.packages = with pkgs; [
    # Navegadores y Apps
    brave
    firefox
    kitty
    
    # Desarrollo
    nodejs
    (pkgs.writeShellScriptBin "gemini" ''
      exec ${pkgs.nodejs}/bin/npx -y @google/gemini-cli "$@"
    '')

    # Utilidades CLI
    neofetch
    ripgrep
    jq
    
            # Dependencias para Neovim (Compiladores, Buscadores)
    
            gcc       # Para compilar Treesitter
    
            fd        # Para Telescope
    
            unzip     # Para instalar LSPs
    
            
    
                # LSPs (Servidores de Lenguaje) - Instalados por Nix, no Mason
    clang-tools             # C/C++ (clangd)
    lua-language-server     # Lua
    pyright                 # Python
    typescript-language-server # JS/TS
    vscode-langservers-extracted # HTML/CSS/JSON
    bash-language-server    # Bash

    # Widgets y Barras
    # (Quickshell eliminado)
    
    # Dependencias de Waybar (Shell Ninja)
    swaynotificationcenter  # Notificaciones
    swww                    # Wallpapers
    rofi                    # Menú (Launcher)
    pavucontrol             # Control de volumen
    networkmanagerapplet    # Icono de red
    
    # Utilidades extras para scripts de Waybar/Hyprland
    wlogout         # Menú de apagado
    cliphist        # Historial clipboard
    wl-clipboard    # Clipboard wayland
    hyprpicker      # Color picker
    hypridle        # Idle daemon
    hyprlock        # Lock screen
    grim            # Screenshots
    slurp           # Selección de área
    swappy          # Editor de screenshots
    btop            # Monitor recursos
    imagemagick     # Procesamiento imagen
    pamixer         # Control volumen CLI
    brightnessctl   # Control brillo
    playerctl       # Control media
    cava            # Visualizador audio

    # Cursores y Temas
    bibata-cursors
    
    # File Manager
    kdePackages.dolphin
    
    # PAQUETES CORE (Gestión Manual de Config)
    hyprland
    waybar
    neovim
  ];

  # --- ENLACES A DOTFILES (Solo Neovim) ---
  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";
  };

  # Habilitar gestión de programas
  programs.home-manager.enable = true;
  programs.git.enable = true;
}
