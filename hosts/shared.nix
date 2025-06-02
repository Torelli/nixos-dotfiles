{ lib
, pkgs
, username
, ...
}: {
  imports = [
    ./modules/substituters.nix
    ./modules/locale.nix
  ];

  # nix
  documentation.nixos.enable = false; # .desktop
  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    settings = {
      experimental-features = "nix-command flakes";

      max-jobs = "auto";
      use-xdg-base-directories = true;
      http-connections = 128;
      max-substitution-jobs = 128;
      log-lines = 25;
      auto-optimise-store = true;
      builders-use-substitutes = true;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = [ "root" "@wheel" "torelli" ];
    };
  };

  #virtualisation
  virtualisation = {
    podman = {
      enable = true;
    };
    docker = {
      enable = true;
    };
  };

  # packages
  environment = {
    systemPackages = with pkgs; [
      pkgs.distrobox
      shared-mime-info
      polkit_gnome
      home-manager
      system-config-printer
      git
      wget
      intel-gpu-tools
      usbutils
      gtklock
      enchant
      hunspell
      hunspellDicts.pt_BR
      hunspellDicts.en_US
      neovim
    ];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
  security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";
  security.pam.services.astal-auth = { };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    source-han-sans
    nerd-fonts.caskaydia-cove
  ];
  fonts.fontDir.enable = true;

  #power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  #programs
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        openssl
      ];
    };
    adb.enable = true;
    dconf.enable = true;
    gamemode = {
      enable = true;
    };
    fish.enable = true;
  };

  # services
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
          	["bluez5.enable-sbc-xq"] = true,
          	["bluez5.enable-msbc"] = true,
          	["bluez5.enable-hw-volume"] = true,
          	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
          }
        '')
      ];
    };
    printing.enable = true;
    printing.drivers = [ pkgs.hplip ];
    flatpak.enable = true;
    # xserver = {
    #   enable = true;
    #   displayManager.gdm.enable = true;
    #   desktopManager.gnome.enable = true;
    # };
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      displayManager = {
        lightdm.enable = true;
      };
    };
    displayManager = {
      # autoLogin.enable = true;
      autoLogin.user = "torelli";
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  networking = {
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    extraHosts = ''
      89.223.71.16   srv
    '';
  };

  # user
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "adbusers"
      "networkmanager"
      "wheel"
      "audio"
      "libvirtd"
      "docker"
      "scanner"
      "gamemode"
      "lp"
    ];
  };

  # network
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # bluetooth
  hardware = {
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true; # for gnome-bluetooth percentage
    };
    sane = {
      enable = true; # enables support for SANE scanners
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };

  # bootloader
  boot = {
    supportedFilesystems = [ "btrfs" "ext4" "exfat" "fat32" "ntfs" ];
    kernel.sysctl = {
      "vm.dirty_background_bytes" = 33554432;
      "vm.dirty_bytes" = 134217728;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "splash"
      "i915.fastboot=1"
    ];
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      efi.canTouchEfiVariables = true;
    };
    consoleLogLevel = 0;
  };

  system.stateVersion = "25.05";
}
