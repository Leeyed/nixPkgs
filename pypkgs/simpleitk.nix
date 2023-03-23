{ pkgs, python39Packages }:
let
  pname = "SimpleITK";
  version = "2.2.1";
  python = pkgs.python39;
  format = "wheel";
in
python.pkgs.buildPythonPackage {
  pname = pname;
  version = version;
  format = format;  
  src = python.pkgs.fetchPypi {
    inherit pname version format;
    sha256 = "9b90dfd94cba0b068bacddaf2550d96df2683df830b9ee71cd9440e64c701196";
    dist = "cp39";
    abi = "cp39";
    python = "cp39";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
  };
  doCheck = false;
}


