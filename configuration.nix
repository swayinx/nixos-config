{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader (GRUB con soporte para Dual Boot en discos separados)
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  # Timezone y Locale
  time.timeZone = "America/Lima";
  i18n.defaultLocale = "en_US.UTF-8";

  # Teclado en consola (TTY)
  console.keyMap = "la-latin1";
  
  # Teclado en X11 (Login screen SDDM)
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  # Usuarios
  users.users.chris = {
    isNormalUser = true;
    description = "Christian";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Permitir software no libre (drivers, chrome, etc)
  nixpkgs.config.allowUnfree = true;
  
  # Paquetes del SISTEMA (Globales para root y todos)
  # Nota: Tus apps personales están en home.nix ahora.
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    ntfs3g # Utilidades NTFS (ntfslabel, ntfsfix)
  ];

  # Habilitar Flakes (CRUCIAL para el futuro)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # --- SERVICIOS ---

  # Hyprland (La base del sistema, la config de usuario está en home.nix)
  programs.hyprland.enable = true;

  # Servicios de detección de discos (Estándar para Dolphin/Thunar)
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Reglas para ocultar particiones de sistema en Dolphin (Solución Global)
  services.udev.extraRules = ''
    # Ocultar particiones de sistema Linux (Raíz, Home, etc)
    SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="xfs", ENV{UDISKS_IGNORE}="1"
    SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ext4", ENV{UDISKS_IGNORE}="1"
    SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="btrfs", ENV{UDISKS_IGNORE}="1"
    
    # Ocultar Swap
    SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="swap", ENV{UDISKS_IGNORE}="1"

    # Ocultar particiones EFI / Boot (Por código GPT estándar)
    SUBSYSTEM=="block", ENV{ID_PART_ENTRY_TYPE}=="c12a7328-f81f-11d2-ba4b-00a0c93ec93b", ENV{UDISKS_IGNORE}="1"
  '';

  # Display Manager (Pantalla de login)
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Gráficos
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # Soporte 32-bit (Steam, Wine)

  # --- DRIVERS NVIDIA ---
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting es OBLIGATORIO para Wayland/Hyprland
    modesetting.enable = true;

    # Gestión de energía (Experimental en NixOS, mejor desactivar si hay dudas)
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Usar drivers privativos (NO open source, mejor rendimiento para GTX 1060)
    open = false;

    # Panel de configuración de nvidia
    nvidiaSettings = true;

    # Usar versión estable
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true; # Gestor gráfico de Bluetooth

  # Gestión de Energía (Batería)
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true; # Perfiles de energía (Waybar)
  services.tlp.enable = false; # Desactivar TLP para evitar conflictos

  # Fuentes (Nerd Fonts para iconos)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
  ];

  # --- MONTURA DE DISCOS PORTABLE ---
  # Montar por Label (Nombre) para que funcione en cualquier PC
  
  # Disco C: (Windows)
  fileSystems."/mnt/c" = {
    device = "/dev/disk/by-label/Windows";
    fsType = "ntfs";
    options = [ "defaults" "nofail" "uid=1000" "gid=100" "umask=022" "x-gvfs-show" ];
  };

  # Disco D: (Datos)
  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-label/Datos";
    fsType = "ntfs";
    options = [ "defaults" "nofail" "uid=1000" "gid=100" "umask=022" "x-gvfs-show" ];
  };

  # Esta línea NO se toca. Es la versión de cuando instalaste NixOS por primera vez.
  system.stateVersion = "25.11"; 
}
