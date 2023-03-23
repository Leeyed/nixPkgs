{ pkgs }:
with pkgs;
let 
  simpleitk = callPackage ./simpleitk.nix { };
  batchgenerators25 = callPackage ./batchgenerators_2_5.nix {};

in
{
  connected-components-3d = callPackage ./connected-components-3d.nix { };
  acvl-utils = callPackage ./acvl-utils.nix { inherit simpleitk batchgenerators25; };
  dynamic-network-architectures = callPackage ./dynamic-network-architectures.nix {};
  MedPy = callPackage ./MedPy.nix { inherit simpleitk; };
  nnUNet = callPackage ./nnUNet.nix { inherit simpleitk batchgenerators25; };
  imagecodecs = callPackage ./imagecodecs.nix { };
  SimpleITK = simpleitk;
  batchgenerators25 = batchgenerators25;
}