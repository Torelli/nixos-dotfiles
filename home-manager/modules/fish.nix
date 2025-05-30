{ ... }: {
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    fish = {
      enable = true;
      generateCompletions = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
        function fish_user_key_bindings
          bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

          bind -M visual y 'fish_clipboard_copy; commandline -f end-selection'

          bind -M default p fish_clipboard_paste
        end
        set fish_cursor_default block

        set fish_cursor_insert line

        set fish_cursor_replace_one underscore
        set fish_cursor_replace underscore

        set fish_cursor_external line

        set fish_cursor_visual block

        set fish_greeting
        clear
      '';
      shellAliases = {
        vim = "nvim";
        ctrl-l = "clear";
        C-l = "ctrl-l";
        control-l = "clear";
        clean = "clear";
        rl = "sudo nixos-rebuild switch --flake $HOME/.nixdots#torelli-laptop";
        cat = "bat";
        ff = "fastfetch";
        ls = "lsd";
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };

}
