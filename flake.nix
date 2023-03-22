{
  description = "myPyPkgs";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.SimpleITKPkgs.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";
  inputs.torchioPkgs.url = "./torchio";
  inputs.monaiPkgs.url = "./monai";
  inputs.pyradiomicsPkgs.url = "./pyradiomics";
  inputs.nnUNetPkgs.url = "./nnUNet";
  inputs.acvl-utilsPkgs.url = "./acvl-utils";
  inputs.connected-components-3dPkgs.url = "./connected-components-3d";
  inputs.dynamic-network-architecturesPkgs.url = "./dynamic-network-architectures";
  inputs.MedPyPkgs.url = "./MedPy";
  # inputs.lowdosepetPkgs.url = "git+ssh://git@github.com/chengaoyu/LowDosePET?ref=liusheng";


  outputs = { self, nixpkgs, flake-utils, SimpleITKPkgs, torchioPkgs, monaiPkgs, pyradiomicsPkgs, nnUNetPkgs, acvl-utilsPkgs, connected-components-3dPkgs, dynamic-network-architecturesPkgs, MedPyPkgs}:
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
          nnUNet = nnUNetPkgs.packages.${system}.nnUNet;
          acvl-utils = acvl-utilsPkgs.packages.${system}.acvl-utils;
          connected-components-3d = connected-components-3dPkgs.packages.${system}.connected-components-3d;
          dynamic-network-architectures = dynamic-network-architecturesPkgs.packages.${system}.dynamic-network-architectures;
          MedPy = MedPyPkgs.packages.${system}.MedPy;
        };

        # devShell = with pkgs; with python39Packages; mkShell {
        #   LD_LIBRARY_PATH = "${stdenv.cc.cc.lib}/lib/:/run/opengl-driver/lib/";
        #   buildInputs = [
        #     click
        #     deprecated
        #     nibabel
        #     humanize
        #     pytorch
        #     tqdm
        #     self.packages.${system}.SimpleITK
        #     self.packages.${system}.torchio
        #   ];
        # };
      }
    )
    );
}
