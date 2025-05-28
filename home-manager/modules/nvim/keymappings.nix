{
  config,
  lib,
  ...
}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = let
      normal =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
        })
        {
          "<Space>" = "<NOP>";

          "j" = "gj";
          "k" = "gk";

          # Esc to clear search results
          "<esc>" = ":noh<CR>";

          # fix Y behaviour
          "Y" = "y$";

          # back and fourth between the two most recent files
          "<C-c>" = ":b#<CR>";

          # save by Space+s or Ctrl+s
          "<leader>s" = ":w<CR>";
          "<C-s>" = ":w<CR>";
          "<C-ы>" = ":w<CR>";

          # navigate to left/right window
          "<C-h>" = "<C-w>h";
          "<C-l>" = "<C-w>l";

          # resize with arrows
          "<C-Up>" = ":resize -2<CR>";
          "<C-Down>" = ":resize +2<CR>";
          "<C-Left>" = ":vertical resize +2<CR>";
          "<C-Right>" = ":vertical resize -2<CR>";

          # move current line up/down
          # M = Alt key
          "<M-j>" = ":move+<CR>";
          "<M-k>" = ":move-2<CR>";

          "<leader>rp" = ":!remi push<CR>";
        };
      visual =
        lib.mapAttrsToList
        (key: action: {
          mode = "v";
          inherit action key;
        })
        {
          # better indenting
          ">" = ">gv";
          "<" = "<gv";
          "<TAB>" = ">gv";
          "<S-TAB>" = "<gv";

          # move selected line / block of text in visual mode
          "K" = ":m '<-2<CR>gv=gv";
          "J" = ":m '>+1<CR>gv=gv";
        };
    in
      config.lib.nixvim.keymaps.mkKeymaps
      {options.silent = true;}
      (normal ++ visual);
  };
}
