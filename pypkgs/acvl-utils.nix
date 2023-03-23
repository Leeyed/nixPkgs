{ pkgs, python39Packages, simpleitk, batchgenerators25, callPackage }:
let
  pname = "acvl_utils";
  version = "0.2";
  python = pkgs.python39;
  connected-components-3d = callPackage ./connected-components-3d.nix { };
in
python.pkgs.buildPythonPackage {
  pname = pname;
  version = version;
  src = python.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-1YY2tQSbC6aYtsusJ83/k1BFjEAylVUFEIN1jDXn2jY=";
  };
  propagatedBuildInputs = with pkgs; with python39Packages; [
    simpleitk
    numpy
    pytorch
    scikitimage
    connected-components-3d
    batchgenerators25
  ];
  doCheck = false;
}