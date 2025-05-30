{ inputs
, pkgs
, username
, ...
}:
{
  home.file."/home/${username}/.config/matugen/config.toml".source = ./config.toml;

  home.file = {
    source = ./scripts;
    recursive = true;
  };

  home.file = {
    source = ./templates;
    recursive = true;
  };
}
