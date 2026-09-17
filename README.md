# Official NixOS Flake repo for Haxefetch 

## How to use this?
- Dependencies for your `configuration.nix`:
```
nix.settings.experimental-features = [ "nix-command" "flakes" ];

programs.nix-ld.enable = true;
```
  


- Trying without install with `shell`:
```
nix shell github:Sbinator-hub/haxefetch-nix
```

- Installing with `add`:
```
nix profile add github:Sbinator-hub/haxefetch-nix
```

- Updating Flake with `upgrade`:
```
nix profile upgrade haxefetch-nix
```

- Removing with `remove`:
```
nix profile remove haxefetch-nix
```
