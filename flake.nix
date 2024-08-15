{
  description = "A nix flake to pull Nightly WezTerm, build it, and push it to cachix.";

  nixConfig = {
    extra-substituters = "https://wezterm-nightly.cachix.org";
    extra-trusted-public-keys = ["wezterm-nightly.cachix.org-1:zsTr51TeTCRg+bHwUr0KfW3XIIb7Avisrj/hXwVzC2c="];
  };

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
