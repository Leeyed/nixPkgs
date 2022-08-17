{
  description = "myPyPkgs";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.SimpleITKPkgs.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";
  inputs.torchioPkgs.url = "./torchio";
  inputs.monaiPkgs.url = "./monai";
  inputs.pyradiomicsPkgs.url = "./pyradiomics";
  # inputs.lowdosepetPkgs.url = "git+ssh://git@github.com/chengaoyu/LowDosePET?ref=liusheng";


  outputs = { self, nixpkgs, flake-utils, SimpleITKPkgs, torchioPkgs, monaiPkgs, pyradiomicsPkgs }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in
      {
        packages = {
          SimpleITK = SimpleITKPkgs.packages.${system}.SimpleITK;
          torchio = torchioPkgs.packages.${system}.torchio;
          monai = monaiPkgs.packages.${system}.monai;
          pyradiomics = pyradiomicsPkgs.packages.${system}.pyradiomics;
          # LowDosePet = lowdosepetPkgs.packages.${system}.LowDosePet;
        };

        devShell = with pkgs; with python39Packages; mkShell {
            buildInputs = [
              click
              deprecated
              nibabel
              humanize
              pytorch
              tqdm
              SimpleITK
              self.packages.${system}.torchio
            ];
        };
      }
    )
    );
}
