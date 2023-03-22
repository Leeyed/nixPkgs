{
  description = "acvl_utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.simpleitk.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";
  inputs.myPyPkgs.url = "git+ssh://git@github.com/Leeyed/nixPkgs?ref=main";

  outputs = { self, nixpkgs, flake-utils, simpleitk, myPyPkgs }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        pname = "acvl_utils";
        version = "0.2";
        python = pkgs.python39;
      in
      {
        packages.acvl-utils = python.pkgs.buildPythonPackage {
          pname = pname;
          version = version;
          src = python.pkgs.fetchPypi {
            inherit pname version;
            sha256 = "sha256-1YY2tQSbC6aYtsusJ83/k1BFjEAylVUFEIN1jDXn2jY=";
          };

          buildInputs = with pkgs; with python39Packages; [
            simpleitk.packages.${system}.SimpleITK
            numpy
            pytorch
            scikitimage
            myPyPkgs.packages.${system}.connected-components-3d
            batchgenerators
          ];
          doCheck = false;
        };

        defaultPackage = self.packages.${system}.${pname};

        apps.${pname} = flake-utils.lib.mkApp {
          drv = self.packages.${system}.${pname};
        };

        defaultApp = self.apps.${system}.${pname};
      }
    )
    );
}
