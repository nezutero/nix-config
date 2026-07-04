{ inputs, ... }:
let
  inherit (inputs.nvf.lib.nvim.dag) entryAnywhere;
in
{
  programs.nvf.settings.vim = {
    luaConfigRC.telescope-theme-fix = entryAnywhere ''
      vim.cmd([[
        hi TelescopeBorder guifg=Grey guibg=NONE ctermfg=Grey ctermbg=NONE
        hi TelescopePrompt guifg=Grey guibg=NONE ctermfg=Grey ctermbg=NONE
        hi TelescopeResults guifg=Grey guibg=NONE ctermfg=Grey ctermbg=NONE
        hi TelescopePreviewBorder guifg=Grey guibg=NONE ctermfg=Grey ctermbg=NONE
        hi TelescopeSelection guifg=Grey guibg=NONE ctermfg=Grey ctermbg=NONE
        hi TelescopeSelectionCaret guifg=Grey guibg=NONE ctermfg=Grey ctermbg=NONE
        hi Normal guibg=NONE ctermbg=NONE
        hi SignColumn guibg=NONE ctermbg=NONE
        hi NormalNC guibg=NONE ctermbg=NONE
        hi VertSplit guibg=NONE ctermbg=NONE
        hi StatusLine guibg=NONE ctermbg=NONE
        hi StatusLineNC guibg=NONE ctermbg=NONE
      ]])
      vim.cmd("hi! link TelescopeNormal Normal")
      vim.cmd("hi! link TelescopeResultsLine Normal")
      vim.cmd("hi! link TelescopePreviewBorder TelescopeNormal")
      vim.cmd("hi! link TelescopePromptBorder TelescopeNormal")
      vim.cmd("hi! link TelescopeSelection TelescopeNormal")
      vim.cmd("hi! link TelescopeSelectionCaret TelescopeNormal")
      vim.cmd("hi! link TelescopeMultiSelection TelescopeNormal")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fh", builtin.help_tags)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
      vim.keymap.set("n", "<C-p>", builtin.git_files)
    '';
  };
}
