{ pkgs, ... }: {
  imports = [
    ./shared.nix
    ./modules/hyprland.nix
    ./hardware/laptop.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      nbfc-linux
    ];
  };

  systemd = {
    services.fix-hyprland-stutters = {
      description = "Sets intel gpu min frequency";
      path = [ pkgs.intel-gpu-tools ];
      script = "intel_gpu_frequency --custom min=800";
      wantedBy = [ "graphical.target" ];
    };
  };

  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;
    auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  services.udev.extraRules = ''
    KERNEL=="rtc0", GROUP="audio"
    KERNEL=="hpet", GROUP="audio"
  '';
}
