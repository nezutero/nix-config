{ inputs, pkgs, ... }:
let
  inherit (inputs.nvf.lib.nvim.dag) entryAnywhere;
in
{
  programs.nvf.settings.vim = {
    startPlugins = [ pkgs.vimPlugins.fidget-nvim ];

    luaConfigRC.lsp-overrides = entryAnywhere ''
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      vim.lsp.config('clangd', {
        cmd = {
          "clangd",
          "--background-index",
          "--query-driver=/run/current-system/sw/bin/*",
        },
      })

      require("fidget").setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
        end,
      })
    '';
  };
}
