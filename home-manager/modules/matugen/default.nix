{ inputs
, pkgs
, ...
}:
let
  matugen = inputs.matugen.packages.${pkgs.system}.matugen;
in
{

  extraConfig = ''
    ${builtins.readFile ./config.toml}
  '';

  home.configFile."gtk-4.0/gtk.css".source = matugen.theme.files/.config/gtk-4/gtk.css;

}
