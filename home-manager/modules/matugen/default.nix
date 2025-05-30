{ inputs
, pkgs
, username
, ...
}:
{
  home.file."/home/${username}/.config/matugen/config.toml".source = ./config.toml;

  home.file."home/${username}/.config/matugen/scripts/" = {
    source = ./scripts;
  };

  home.file."home/${username}/.config/matugen/templates/" = {
    source = ./templates;
  };
}
