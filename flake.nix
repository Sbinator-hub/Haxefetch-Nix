{
  description = "Haxefetch - a fetch program written in Haxe";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    haxefetch-src = {
      url = "github:Sbinator-hub/Haxefetch";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, flake-utils, haxefetch-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "haxefetch";
          version = "git";
          src = haxefetch-src;
          dontBuild = true;
          nativeBuildInputs = [ pkgs.autoPatchelfHook ];
          buildInputs = [ pkgs.stdenv.cc.cc.lib ];
          installPhase = ''
            mkdir -p "$out/bin"
            cp binary/haxefetch "$out/bin/haxefetch"
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
          packages = [ pkgs.haxe pkgs.neko pkgs.git ];
        };
      });
}
