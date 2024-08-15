{
  description = "A nix flake to pull Nightly WezTerm, build it, and push it to cachix.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "systems";
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = { self, nixpkgs, systems, wezterm }: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    packages = eachSystem (system: {
      default = wezterm.packages.${system}.default;
    });
  };
}
