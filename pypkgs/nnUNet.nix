{ pkgs, python39Packages, callPackage, simpleitk, batchgenerators25 }:
let
  pname = "nnUNet";
  version = "2.0";
  # format = "wheel";
  python = pkgs.python39;
  acvl-utils = callPackage ./acvl-utils.nix { inherit simpleitk batchgenerators25; };
  dynamic-network-architectures = callPackage ./dynamic-network-architectures.nix {};
  MedPy = callPackage ./MedPy.nix { inherit simpleitk; };
  imagecodecs = callPackage ./imagecodecs.nix { };
in
python.pkgs.buildPythonPackage {
  pname = "${pname}";
  version = "${version}"; 
  propagatedBuildInputs = with python39Packages; [
    pytorch
    tqdm
    dicom2nifti
    acvl-utils
    dynamic-network-architectures
    MedPy
    scikitimage
    scipy
    batchgenerators25
    numpy
    scikit-learn
    simpleitk
    pandas
    graphviz
    tifffile
    requests
    nibabel
    matplotlib
    seaborn
    imagecodecs
    yacs
  ];
  LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib/:/run/opengl-driver/lib/";

  src = pkgs.fetchFromGitHub {
    owner = "MIC-DKFZ";
    repo = pname;
    rev = "93e1f4afddd22fada75123e64f186a61a0522fe8";
    sha256 = "sha256-GRIFtFz9hM4Cx+GkP9JQAA1uosJBu5RNKOcmgEP0dW0=";
  };
}