{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      nerdcommenter
      nerdtree
      vim-devicons
      fzf-vim
      wal-vim
    ];
    extraConfig = ''
      syntax on
      set encoding=UTF-8
      set relativenumber
      set laststatus=2
      set noshowmode
      set softtabstop=4
      set title
      set nohlsearch

      set expandtab
      set number
      set tabstop=4
      set shiftwidth=4

      let g:airline#extensions#tabline#enabled = 1
      let g:airline_powerline_fonts = 1

      colorscheme wal
    '';
  };

  home.packages = with pkgs; [
    gcc
    unzip
  ];
}
