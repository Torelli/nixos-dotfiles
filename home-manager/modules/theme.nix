{ config
, pkgs
, inputs
, ...
}: {
  home = {
    packages = with pkgs; [
      adw-gtk3
      colloid-icon-theme
      bibata-cursors
      cantarell-fonts
    ];
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "adw-gtk3-dark";
    color-scheme = "prefer-dark";
  };
  gtk = {
    enable = true;
    gtk4.extraCss = config.gtk.gtk3.extraCss;
    gtk3.extraCss = ''
      @import url("file://${config.xdg.configHome}/gtk-4.0/colors.css");
    '';
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-decoration-layout = "menu:";
    };
    gtk4.extraConfig = {
      gtk-decoration-layout = "menu:";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid";
    };
    font = {
      package = pkgs.cantarell-fonts;
      name = "Cantarell";
      size = 11;
    };
  };
  qt = {
    enable = true;
    platformTheme = {
      name = "gtk";
    };
    style.name = "adwaita-dark";
  };
  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];
}
