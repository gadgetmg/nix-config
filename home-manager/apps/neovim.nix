{ pkgs, ... }:

{
  home.packages = with pkgs; [
    docker-compose-language-service
    dockerfile-language-server-nodejs
    gcc
    jsonnet-language-server
    lua-language-server
    marksman
    neovim
    nil
    nodePackages_latest.bash-language-server
    nodePackages_latest.coc-vimlsp
    pylyzer
    pyright
    python311Packages.python-lsp-server
    ripgrep
    rust-analyzer
    sqls
    stylua
    typos-lsp
    unzip
    vscode-langservers-extracted
    yaml-language-server
  ];
}
