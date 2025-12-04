{
  description = "Advent of Code in Fennel";

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
        packages.default = pkgs.writeShellScriptBin "aoc" ''
          if [ $# -eq 0 ]; then
            echo "Usage: aoc <day-number> <test (optional)>"
            exit 1
          fi

          DAY="d$1"
          TEST="$2"
          if [ $# -eq 1 ]; then
            INPUT="$DAY.txt"
          else
            if [ "$TEST" != "test" ]; then
              echo "Usage: aoc <day-number> <test (optional)>"
              exit 1
            fi
            INPUT="$DAY-$TEST.txt"
          fi

          ${pkgs.luajitPackages.fennel}/bin/fennel "$DAY.fnl" "inputs/$INPUT"
        '';
        devShells.default = pkgs.mkShell { buildInputs = my-buildInputs; };
      });
}
