{ inputs
, pkgs
, username
, ...
}:
{
  home.file."/home/${username}/.config/matugen/config.toml".source = ./config.toml;

  home.file."/home/${username}/.config/matugen/scripts" = {
    source = ./scripts;
    recursive = true;
  };

  home.file."/home/${username}/.config/matugen/templates" = {
    source = ./templates;
    recursive = true;
  };
}
