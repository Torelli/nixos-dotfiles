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

      #gui
      onlyoffice-desktopeditors
      lutris
      obs-studio
      wpsoffice
      zoom-us
      kitty
      foot
      yazi
      mpv
      vesktop
      zathura
      loupe
      simple-scan
      fragments
      transmission_4-gtk
      ghex
      hiddify-app
      cassette
      spotify
      kdePackages.qt6ct
      libsForQt5.qt5ct
      zenity
      inputs.zen-browser.packages."${system}".default

      #hypr
      inputs.hyprsettings.packages."${pkgs.system}".default
      socat # for monitor connect script
      hyprpicker
      hypridle
      wl-gammactl
      wl-clipboard
      wf-recorder
      grimblast
      pavucontrol
      brightnessctl
      swww
      gsettings-desktop-schemas
      material-icons
      corefonts
      grim
      slurp

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
