{ pkgs, python39Packages }:
let
  pname = "dynamic_network_architectures";
  version = "0.2";
  # format = "wheel";
  python = pkgs.python39;
in
python.pkgs.buildPythonPackage {
  pname = pname;
  version = version;
  # format = format;
  src = python.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-8YpxX2qZRVdBq4mBi4Fm/OME1iuVwWKWVvKTNI/+YT4=";
    # sha256 = pkgs.lib.fakeSha256;
    # dist = "cp39";
    # abi = "cp39";
    # python = "cp39";
    # platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
  };
  buildInputs = with pkgs; with python39Packages; [
    pytorch
  ];
  doCheck = false;
}