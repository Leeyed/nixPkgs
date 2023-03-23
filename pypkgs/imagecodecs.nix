{ pkgs, python39Packages }:
let
  pname = "imagecodecs";
  version = "2023.3.16";
  format = "wheel";
  python = pkgs.python39;
in
python.pkgs.buildPythonPackage {
  pname = pname;
  version = version;
  format = format;
  src = python.pkgs.fetchPypi {
    inherit pname version format;
    # sha256 = "sha256-uYpu97Hr7Ura5zBCv+zug3A7/y8YwNPc4p7E/RPicbE=";
    sha256 = "c5687a264fb66929a406512d384a1b082fa2256f556860ddbfb13b0ac268c942";
    dist = "cp39";
    abi = "cp39";
    python = "cp39";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
  };
  buildInputs = with pkgs; with python39Packages; [
    cython
    numpy
  ];
  doCheck = false;
}

# { pkgs, python39Packages }:
# let
#   pname = "imagecodecs";
#   version = "2023.3.16";
#   format = "wheel";
#   python = pkgs.python39;
#   # connected-components-3d = callPackage ./connected-components-3d.nix { };
# in
# python.pkgs.buildPythonPackage {
#   pname = pname;
#   version = version;
#   format = format;
#   src = python.pkgs.fetchPypi {
#     inherit pname version;
#     sha256 = "sha256-1YY2tQSbC6aYtsusJ83/k1BFjEAylVUFEIN1jDXn2jY=";
#   };
#   buildInputs = with pkgs; with python39Packages; [
#     # simpleitk
#     numpy
#     # pytorch
#     # scikitimage
#     # connected-components-3d
#     # batchgenerators
#   ];
#   doCheck = false;
# }