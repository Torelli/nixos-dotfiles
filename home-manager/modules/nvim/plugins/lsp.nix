{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
            "<leader>f" = "open_float";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            ca = "code_action";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          svelte.enable = true;
          ts_ls.enable = true;
          eslint.enable = true;
          emmet_ls.enable = true;
          bashls.enable = true;
          lua_ls.enable = true;
          nil_ls.enable = true;
          texlab.enable = true;
          pyright.enable = true;
          omnisharp = {
            enable = true;
            extraOptions = {
              enable_rosyln_analyzers = true;
              enable_import_completion = true;
              organize_imports_on_format = true;
              enable_editorconfig_support = true;
              analyze_open_documents_only = true;
            };
          };
          rust_analyzer = {
            installCargo = true;
            installRustc = true;
            enable = true;
          };
        };
      };
    };
  };
}
