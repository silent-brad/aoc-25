{
  description = "Fennel Dev Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        my-buildInputs = with pkgs; [
          luajit
          luajitPackages.fennel
          fennel-ls
          fnlfmt
        ];
      in {
        packages.default = pkgs.writeShellScriptBin "run" ''
          ${pkgs.luajitPackages.fennel}/bin/fennel -c main.fnl > main.lua
          #LUA_PATH="?.lua;../?.lua;"
          ${pkgs.luajit}/bin/luajit main.lua
        '';
        devShells.default = pkgs.mkShell { buildInputs = my-buildInputs; };
      });
}
