{ ... }:

{
  programs.nvf.settings.vim = {
    options = {
      number = true;
      relativenumber = true;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      mouse = "a";
      smartindent = true;
      wrap = true;

      swapfile = false;
      backup = false;
      undofile = true;

      hlsearch = false;
      incsearch = true;

      termguicolors = true;

      scrolloff = 8;

      updatetime = 50;

      textwidth = 100;
      colorcolumn = "90";

      breakindent = true;
      linebreak = true;

      fillchars = {
        eob = " ";
      };
    };
  };
}
