{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      theme = {
        name = "kanagawa";
      };

      lsp = {
        enable = true;

        servers = {
          bashls.enable = true;
          clangd.enable = true;
          gopls.enable = true;
          html.enable = true;
          cssls.enable = true;
          rust_analyzer.enable = true;
          zls.enable = true;
          marksman.enable = true;
          nil_ls.enable = true;
          lua_ls.enable = true;
        };
      };

      autocomplete.nvim-cmp.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
      git.gitsigns.enable = true;
      undoFile.enable = true;
      comments.enable = true;
    };
  };
}
