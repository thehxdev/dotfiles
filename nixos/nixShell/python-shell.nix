{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [
      python311Full
      python311Packages.virtualenv
      python311Packages.ipython
      python311Packages.python-lsp-server
      #ruff
    ];
}
