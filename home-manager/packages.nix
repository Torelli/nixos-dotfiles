{ inputs
, pkgs
, ...
}: {
  home.packages = with pkgs;
    with nodePackages_latest; [
      #cli
      devenv
      clipse
      btop
      ctop
      fd
      ripgrep
      fzf
      inotify-tools
      ffmpeg
      libnotify
      killall
      p7zip
      gh
      tesseract
      starship

      #tools
      ripdrag
      nekoray
      wineWowPackages.waylandFull
      winetricks
      pamixer
      blueman
      wayshot
      usbguard
      usbguard-notifier

      #gui
      onlyoffice-desktopeditors
      lutris
      obs-studio
      obsidian
      wpsoffice
      zoom-us
      kitty
      foot
      yazi
      mpv
      vesktop
      evince
      loupe
      simple-scan
      transmission_4-gtk
      ghex
      hiddify-app
      spotify
      kdePackages.qt6ct
      libsForQt5.qt5ct
      zenity
      zrythm
      inputs.zen-browser.packages."${system}".default
      satty

      #hypr
      inputs.hyprsettings.packages."${pkgs.system}".default
      socat # for monitor connect script
      hyprpicker
      hyprshade
      hypridle
      wl-gammactl
      wl-clipboard
      wf-recorder
      grimblast
      pavucontrol
      better-control
      brightnessctl
      swww
      gsettings-desktop-schemas
      material-icons
      corefonts
      grim
      slurp
      waypaper

      #development
      dbeaver-bin
      docker-compose
      android-studio

      # langs
      nixd
      nodejs
      bun
      sassc
      meson
      yarn
    ];
}
