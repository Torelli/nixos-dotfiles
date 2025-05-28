{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<C-n>";
        action = ":NvimTreeToggle<CR>";
        options.silent = true;
      }
    ];

    plugins.nvim-tree = {
      enable = true;
    };
  };
}
