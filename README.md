# Wezterm Nightly Flake

A Nix Flake that automatically builds the latest WezTerm with Github Actions

> [!IMPORTANT]  
> Merged upstream https://github.com/wez/wezterm/pull/5979

## Usage

WezTerm is exposed as this flake's default package. Just add it to your config somewhere like `environment.systemPackages` to use.

```nix
{inputs, pkgs, ...}:{
  environment.systemPackages = [
    inputs.wezterm-nightly.packages.${pkgs.system}.default
  ];
}
```

### Home Manager

```nix
{inputs, pkgs, ...}:{
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm-nightly.packages.${pkgs.system}.default
  }
}
```

## Binary Cache

The `flake.lock` is automatically updated daily. After it's updated, the WezTerm is rebuilt with the updated `flake.lock`. If that passes, the build is pushed to main for your enjoyment.
Everything that was built is pushed to the `wezterm-nightly.cachix.org` cache. You can either use the provided `nixConfig` when prompted, or add the cachix to your trusted substitutes.
