{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    settings.vim = {
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
      treesitter = {
        enable = true;
        addDefaultGrammars = true;
      };
      git.gitsigns.enable = true;
      telescope.enable = true;
      comments.comment-nvim.enable = true;
      utility.undotree.enable = true;
    };
  };
}
