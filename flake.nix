{
  description = "knave-preview, a local preview server for static site builds";

  inputs = {
    knave.url = "github:knave-lang/knave/v0.14.21";
    nixpkgs.follows = "knave/nixpkgs";
  };

  outputs =
    { knave, nixpkgs, ... }:
    {
      devShells = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ] (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [
              knave.packages.${system}.default
              pkgs.cargo
            ];
          };
        }
      );
    };
}
