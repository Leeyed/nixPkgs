{
  description = "myPyPkgs";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.11";
  # inputs.SimpleITKPkgs.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";
  # inputs.torchioPkgs.url = "./torchio";
  # inputs.monaiPkgs.url = "./monai";
  # inputs.pyradiomicsPkgs.url = "./pyradiomics";
  # inputs.nnUNetPkgs.url = "./nnUNet";
  # inputs.acvl-utilsPkgs.url = "./acvl-utils";
  # inputs.dynamic-network-architecturesPkgs.url = "./dynamic-network-architectures";
  # inputs.MedPyPkgs.url = "./MedPy";
  # inputs.lowdosepetPkgs.url = "git+ssh://git@github.com/chengaoyu/LowDosePET?ref=liusheng";


  outputs = { self, nixpkgs, flake-utils}:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in
      {
        packages = import ./pypkgs { inherit pkgs; };
        # packages.SimpleITK = SimpleITKPkgs.packages.${system}.SimpleITK;
      }
    )
    );
}
