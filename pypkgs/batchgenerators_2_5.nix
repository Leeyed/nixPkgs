{ pkgs, python39Packages }:
let
  pname = "batchgenerators";
  version = "0.25";
  python = pkgs.python39;
in
python.pkgs.buildPythonPackage {
  pname = pname;
  version = version;
  src = python.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-OKZ0E+hH/zZ+ZKusNjMfywZUlCAtUmrpb3ZE3joOVJU=";
  };
  propagatedBuildInputs = with pkgs; with python39Packages; [
    future
    numpy
    pillow
    scipy
    scikit-learn
    scikitimage
    threadpoolctl
    unittest2
  ];
  doCheck = false;
}
