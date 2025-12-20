{ pkgs, ... }:

let
  disabledPackages = [
    # "protonvpn-gui"
  ];
in
{
  nixpkgs.overlays = [
    (
      final: prev:
      # Turn each disabled package into a dummy derivation
      builtins.listToAttrs (
        map (name: {
          inherit name;
          value = pkgs.runCommand "dummy-${name}" { } ''
            echo "Disabled package: ${name}" >&2
            mkdir -p $out
          '';

        }) disabledPackages
      )
    )
  ];
}
