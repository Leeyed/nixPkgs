{ pkgs, python39Packages }:
let
  pname = "SimpleITK";
  version = "2.1.1.2";
  python = pkgs.python39;
  format = "wheel";
in
python.pkgs.buildPythonPackage {
  pname = pname;
  version = version;
  format = format;  
  src = python.pkgs.fetchPypi {
    inherit pname version format;
    sha256 = "sha256-+JUGHTUcuYEK1SMefPeMe1zi7YA55uMURtt1V/b5nEY=";
    dist = "cp39";
    abi = "cp39";
    python = "cp39";
    platform = "manylinux_2_12_x86_64.manylinux2010_x86_64";
  };
  doCheck = false;
}
