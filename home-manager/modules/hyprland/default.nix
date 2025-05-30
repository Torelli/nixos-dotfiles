{ inputs
, pkgs
, ...
}:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;

  swww = pkgs.writeShellScript "swww" ''
    ${builtins.readFile ./bin/swww.sh}
  '';

  monitor_connect = pkgs.writeShellScript "monitor_connect" ''
    ${builtins.readFile ./bin/handle_monitor_connect.sh}
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = [
        "${swww}"
        "${monitor_connect}"
      ];
    };
    extraConfig = ''
      ${builtins.readFile ./hyprland.conf}
      ${builtins.readFile ./colors.conf}
      ${builtins.readFile ./monitors.conf}
      ${builtins.readFile ./autostart.conf}
      ${builtins.readFile ./animations.conf}
      ${builtins.readFile ./input.conf}
      ${builtins.readFile ./windowrules.conf}
      ${builtins.readFile ./keybindings.conf}
      ${builtins.readFile ./layerrules.conf}
    '';
  };

  home.configFile."~/.config/hypr/hyprlock.conf".source = ./hyprlock.conf;

  home.configFile."~/.config/hypr/hypridle.conf".source = ./hypridle.conf;
}
