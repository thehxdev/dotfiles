{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [
        rustc
        cargo
        rustfmt
        clippy
        rust-analyzer
        gcc
        gdb
        #radare2
    ];
}

