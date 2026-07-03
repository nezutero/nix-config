{ ... }:

{
  programs.nvf.settings.vim = {
    globals.mapleader = " ";

    keymaps = [
      # file explorer
      {
        mode = "n";
        key = "<leader>ww";
        action = ":Ex<CR>";
      }

      # move lines
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }

      # paste without yanking
      {
        mode = "x";
        key = "<leader>p";
        action = "\"_dP";
      }

      # yank
      {
        mode = [ "n" "v" ];
        key = "<leader>y";
        action = "\"+y";
      }
      {
        mode = "n";
        key = "<leader>Y";
        action = "\"+Y";
      }

      # format
      {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
      }

      # quickfix navigation
      {
        mode = "n";
        key = "<C-k>";
        action = "<cmd>cnext<CR>zz";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<cmd>cprev<CR>zz";
      }
      {
        mode = "n";
        key = "<leader>k";
        action = "<cmd>lnext<CR>zz";
      }
      {
        mode = "n";
        key = "<leader>j";
        action = "<cmd>lprev<CR>zz";
      }

      # replace word under cursor
      {
        mode = "n";
        key = "<leader>s";
        action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
      }

      # chmod +x
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>!chmod +x %<CR>";
        options.silent = true;
      }

      # reload config
      {
        mode = "n";
        key = "<leader><leader>";
        action = "<cmd>so<CR>";
      }

      # trouble
      {
        mode = "n";
        key = "<leader>t";
        action = "<cmd>Trouble<CR>";
        options.silent = true;
      }

      # disable arrows
      { mode = [ "n" "i" "v" ]; key = "<Up>"; action = "<nop>"; }
      { mode = [ "n" "i" "v" ]; key = "<Down>"; action = "<nop>"; }
    ];
  };
}
