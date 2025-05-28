{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./barbar.nix
    ./comment.nix
    ./efm.nix
    ./lsp.nix
    ./lualine.nix
    ./nvimtree.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimtex.nix
    ./noice.nix
  ];

  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-tpipeline
      (pkgs.vimUtils.buildVimPlugin {
        name = "transparent-nvim";
        src = inputs.transparent-nvim;
      })
    ];

    colorschemes.one.enable = true;

    plugins = {
      web-devicons.enable = true;
      direnv.enable = true;
      gitsigns.enable = true;
      emmet.enable = true;
      vim-surround.enable = true;
      tmux-navigator.enable = true;
      nvim-autopairs.enable = true;
      nvim-colorizer.enable = true;
      indent-blankline.enable = true;
    };
  };
}
