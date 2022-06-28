{
  description = "myPyPkgs";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.SimpleITKPkgs.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";
  inputs.torchioPkgs.url = "./torchio";
  inputs.monaiPkgs.url = "./monai";
  inputs.lowdosepetPkgs.url = "git+ssh://git@github.com/chengaoyu/LowDosePET.git?ref=main";


  outputs = { self, nixpkgs, flake-utils, SimpleITKPkgs, torchioPkgs, monaiPkgs }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in
      {
        packages = {
          SimpleITK = SimpleITKPkgs.packages.${system}.SimpleITK;
          torchio = torchioPkgs.packages.${system}.torchio;
          monai = monaiPkgs.packages.${system}.monai;
          LowDosePet = lowdosepetPkgs.packages.${system}.LowDosePet;
        };


      }
    )
    );
}
