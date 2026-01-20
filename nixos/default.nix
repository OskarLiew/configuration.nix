{
  pkgs,
  system,
  inputs,
  ...
}:
{
  nixbtw = inputs.nixpkgs.lib.nixosSystem {
    inherit pkgs system;
    modules = [ ./nixbtw ];
    specialArgs = { inherit inputs; };
  };
  static = inputs.nixpkgs.lib.nixosSystem {
    inherit pkgs system;
    modules = [ ./static ];
    specialArgs = { inherit inputs; };
  };
}
