{ pkgs, python39Packages, callPackage, simpleitk }:
let
  pname = "MedPy";
  version = "0.4.0";
  # format = "wheel";
  python = pkgs.python39;

in
python.pkgs.buildPythonPackage {
  pname = pname;
  version = version;
  # format = format;
  src = python.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-+KlJN9u5R6sGnnZ4YtxrholrFTxBzo7ZNpx9ecADOog=";
    # sha256 = pkgs.lib.fakeSha256;
    # dist = "cp39";
    # abi = "cp39";
    # python = "cp39";
    # platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
  };
  buildInputs = with pkgs; with python39Packages; [
    numpy
    simpleitk
    scipy
  ];
  doCheck = false;
}