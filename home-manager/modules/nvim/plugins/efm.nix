{
  programs.nixvim = {
    plugins = {
      lsp.servers.efm = {
        enable = true;
        filetypes = ["nix" "bash" "sh" "typescript" "typescriptreact" "javascript" "javascriptreact" "svelte" "python" "html" "css"];
        extraOptions.init_options = {
          documentFormatting = true;
          documentRangeFormatting = true;
          hover = true;
          documentSymbol = true;
          codeAction = true;
          completion = true;
        };
      };

      lsp-format = {
        enable = true;
        lspServersToEnable = ["efm"];
      };

      efmls-configs = {
        enable = true;
        setup = {
          python = {
            formatter = "black";
          };
          rust = {
            formatter = "rustfmt";
          };
          bash = {
            formatter = "shfmt";
            linter = "shellcheck";
          };
          javascript = {
            formatter = ["eslint_d" "prettier_d"];
            linter = "eslint_d";
          };
          typescript = {
            formatter = ["eslint_d" "prettier_d"];
            linter = "eslint_d";
          };
          svelte = {
            formatter = ["eslint_d" "prettier_d"];
            linter = "eslint_d";
          };
          nix = {
            formatter = "alejandra";
            linter = "statix";
          };
          html = {
            formatter = "prettier_d";
          };
          css = {
            formatter = "prettier_d";
          };
        };
      };
    };
  };
}
