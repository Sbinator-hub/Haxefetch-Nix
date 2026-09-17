{
  description = "Haxefetch - a fetch program written in Haxe";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "haxefetch";
          version = "git";
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/Sbinator-hub/Haxefetch/main/binary/haxefetch";
            hash = "sha256-7PmRVTexbWdnQAh7FkL+XFR3emg0Jl00sRE6XrlSQ6Y=";
          };
          dontUnpack = true;
          dontBuild = true;
          installPhase = ''
            mkdir -p "$out/bin"
            cp "$src" "$out/bin/haxefetch"
            chmod +x "$out/bin/haxefetch"
          '';
          meta = {
            description = "A fetch program written in Haxe";
            homepage = "https://github.com/Sbinator-hub/Haxefetch";
            license = pkgs.lib.licenses.mit;
            platforms = pkgs.lib.platforms.linux;
            mainProgram = "haxefetch";
          };
        };
        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.default;
          exePath = "/bin/haxefetch";
        };
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.haxe
            pkgs.neko
            pkgs.git
          ];
        };
      });
}
