{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [
        gcc
        libcxx
        gnumake
        ccls
        gdb
        valgrind
        #radare2
    ];
}