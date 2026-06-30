{
  config,
  pkgs,
  ...
}: {
  # Move dependencies to system packages (or scope to users.users.<name>.packages)
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withRuby = false;
    withPython3 = false;

    configure = {
      # Plugins are loaded via the packages.<name>.start array
      packages.neovimPlugins = with pkgs.vimPlugins; {
        start = [
          lualine-nvim
          nvim-web-devicons
          nvim-treesitter.withAllGrammars
        ];
      };

      # Vimscript and Lua configurations are combined into customRC
      customRC = ''
        " Core UI settings
        set number
        set relativenumber

        set notermguicolors

        set cursorline
        set signcolumn=yes
        set clipboard=unnamedplus

        highlight Normal ctermbg=NONE guibg=NONE
        highlight NonText ctermbg=NONE guibg=NONE
        highlight LineNr ctermbg=NONE guibg=NONE
        highlight SignColumn ctermbg=NONE guibg=NONE
        highlight EndOfBuffer ctermbg=NONE guibg=NONE

        " Wrap initLua contents in a Lua heredoc
        lua << EOF
        -- Statusline
        require('lualine').setup({
          options = {
            theme = 'auto',
            icons_enabled = true,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
          }
        })
        EOF
      '';
    };
  };
}
